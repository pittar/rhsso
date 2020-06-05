# Install Red Hat SSO on OpenShift
First draft at installing RH-SSO as an authentication provider for OpenShift

login to OpenShift using a cluster-admin user

You must first create an overlay specific to your domain:
cp -R rhsso/overlays/myocp rhsso/overlays/MYDOMAIN

update domain specific configuration in this directory

The script will setup a user in RedHat SSO with OpenShift cluster-admin privileges. The user by default is ocpadmin/password. We encourage you to update the password in openshift-user.yaml before proceeding

without ARGOCD:

./setup.sh

oc apply -k rhsso/overlays/MYDOMAIN

