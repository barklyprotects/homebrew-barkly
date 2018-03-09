Kubernetes project
=================
The kubernetes project under homebrew-barkly serves a few purposes. We're in the process of switching over to [kops](https://github.com/kubernetes/kops) to manage our environments.  This will make configuration and cert management much easier.

Prerequisites
-------------
You should have credentials setup to work against aws using the aws cli.  If you can run this, then you're in good shape:
```
aws s3 ls s3://barkly-kops
```
Getting started
----------------
This project will install Kubernetes dependencies, and set an env variable to tell `kops` how to retrieve cluster configs.

Once you've added this project to your projects file (`echo kubernetes >> ~/barkly/projects`) run brew barkly to install dependencies.

Open a fresh shell and you should see the env variable for kops defined: `KOPS_STATE_STORE`.

Assuming your s3 configs are setup, you should now be able setup your environment:

```
# list clusters
kops get clusters
# get cluster configs for kubectl
kops export kubecfg --name <cluster name>
# Run other kubernetes commands
kubectl get pods
```
Tips
----

We install kubectx which you should learn more about here: https://github.com/ahmetb/kubectx
Aliases
-------
As you can see in the `kops.sh` file we've setup some aliases to make it easy to switch between environments.

We've also created an alias for `kubectl` called `k` that will use a k8s environment based on a context or namespace defined in an environment variable:
```
$KUBECTL_CONTEXT
$KUBECTL_NAMESPACE
```

This makes it easy to have multiple terminals open working on different k8s clusters.
