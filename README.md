# Gitops 

This repository contains some samples and tests made with GitOps approach. Each branch is a different case. Navigate between the branch to find the use case you look for. 

## Basic CP4I deployment

The main branch contains a deployment of CP4I on an exisiting cluster.

### Prerequisite

* An exisiting OCP cluster.
* GitOps instance deployed and configured (scripts to deploy it could be located [here](https://github.com/jtarte/cp_install_resources/tree/master/gitops))
* Storage solutions aligned with CP4I requirements (here we use OpenShift Data Foundation)

### IBM entitlment key
if you are planning to use the IBM registry, you need to provide the IBM entitlment key. You could either provide the key to the global pull secret, either a the namespace level.

If your choice is to do it a namespace level, you should add the secret with entitlment key in `openshif-gitops` namespace. Then use the set-ibm-entitlement job to copy the key into the target namespace. The job creation is part of the gitops synchronisation. 

### Deploy CP4I

First, deploy the base

``` 
oc apply -f applications/base-appset.yaml
```

Once all the requested operators are deployed, you could deploy the platform navigator.

```
oc apply -f applications/platform-navigator-application.yaml
```

