# Install Red Hat SSO on OpenShift
First draft at installing RH-SSO as an authentication provider for OpenShift

login to OpenShift using a cluster-admin user

You must first create an overlay specific to your domain:
```
$ cp -R rhsso/overlays/myocp rhsso/overlays/<MYDOMAIN>
```

Update domain specific configuration in this directory

## Using Kustomize

Create the Red Hat SSO Operator.
```
$ oc apply -k rhsso-operator/overlays/default
```

This will create the operator `InstallPlan` and `Subsription`, as well as a `Job` that will appove the manual install plan and create a certificate secret.

Create the RH-SSO instance:
```
$ oc apply -k rhsso/overlays/<MYDOMAIN>
```

This will create the Red Hat SSO instance, an "openshift" realm, client, and inital admin user (ocpadmin).  It also creats a new `OAuth` custom resource to tell OpenShft to use Red Hat SSO for login.

This will take a few mintues for Red Hat SSO to install, then it may still take a few minutes longer after that for the authentication pods to cycle for RH-SSO to become available as the login service.

## Argo CD or Script


The script will setup a user in Red Hat SSO with OpenShift cluster-admin privileges. The user by default is ocpadmin/password. We encourage you to update the password in openshift-user.yaml before proceeding

without ARGOCD:

./setup.sh

oc apply -k rhsso/overlays/MYDOMAIN

