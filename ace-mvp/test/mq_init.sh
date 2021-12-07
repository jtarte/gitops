#!/bin/bash
echo "Cleaning"
rm app1key.*
rm *.crt

echo "Get certificates"
oc extract secret/mq-mvp-instance-tls -n mvp --keys=ca.crt --to=. --confirm
oc extract secret/mq-mvp-instance-tls -n mvp --keys=tls.crt --to=. --confirm

echo "Create certificate db"
runmqakm -keydb -create -db app1key.kdb -pw password -type cms -stash

runmqakm -cert -add -db app1key.kdb -label ca -file ca.crt -format ascii -stashed
runmqakm -cert -add -db app1key.kdb -label myqm -file tls.crt -format ascii -stashed

runmqakm -cert -list -db app1key.kdb -stashed

echo "Creating ccdt.json"
MYROUTE=$(oc get route -n mvp bahbrkp1-ibm-mq-qm  -o jsonpath={.spec.host})

sed "s/ROUTE/$MYROUTE/g" ccdt.json.template > ccdt.json


export MQCCDTURL=$(pwd)/ccdt.json
export MQSSLKEYR=$(pwd)/app1key

echo "Sending a message test"
echo "Test message 1" | amqsputc TEST BAHBRKP1
echo "Geting a message test"
amqsgetc TEST.IN BAHBRKP1
