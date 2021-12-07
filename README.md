# Gitops : test A

In this branch, you could find the files needed for test A.

## Prerequisties

* OCP platform
* GitOps server deployed on OCP
* pull secret to container registries (eithet cp.icr.io or private registry in case of Airgap for example) is configured
* enable the user workload monitoring on OCP



## Deployment

1. Clone the git repo.

2. Create the project inside GitOps instance.
    ``` 
    oc apply -f project/
    ```

3. Deploy the base (including ibm catalog, cp4i operators, ibm common services)
    ```
    oc apply -f applications/base-appset.yaml
    ```
    you could monitor the deployment of CSV, then the deployment of pods in `ibm-common-services` namespace. Once all the pods are running, you could move to next steps.

4. Deploy the CP4I cartridge
    ```
    oc apply -f applications/cp4i-appset.yaml
    ```

5. Deploy MQ
    ``` 
    oc apply -f applications/mq-mvp-appset.yaml
    ```

6. Deploy ACE app
    ```
    oc apply -f applications/ace-test.yaml
    ```

7. Make a test. From `./ace-mvp/test` directory, use the `mq_init.sh` script to test the connectivity with the platform and the test application flow.

8. on Grafana instance (launched from the Cloud Pak console), you could import the grafana dashboard `./mq-mvp/mq-ace-dashboard.json`

