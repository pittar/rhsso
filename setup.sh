#!/bin/bash

LANG=C

echo ""
echo "Installing RH-SSO Operator."

oc apply -k rhsso-operator/overlays/default

echo "Pause 15 seconds for the creation of the InstallPlan."
sleep 15

echo "Approving operator installation."
IPNAME=$(oc get installplan -n sso -o jsonpath='{range .items[*].metadata}{.name}{end}')
echo "($IPNAME)"
oc patch -n sso installplan $IPNAME --type=json -p='[{"op":"replace","path": "/spec/approved", "value": true}]'

echo "Pausing for 10 seconds for operator initialization..."

sleep 10

echo "Trusting OpenShift certificate"

# Get name of certs secret.  It can be router-certs or router-certs-default.
CERT_SECRET=$(oc get secrets -n openshift-ingress | grep router-certs | cut -d ' ' -f1)

tlscert=`oc get secrets/$CERT_SECRET -o jsonpath={.data.'tls\.crt'} -n openshift-ingress | base64 --decode`
oc delete configmap openidcacrt -n openshift-config
oc create configmap openidcacrt --from-literal ca.crt="$tlscert" -n openshift-config

echo "Granting cluster admin privileges to ocpadmin user"
oc adm policy add-cluster-role-to-user cluster-admin  ocpadmin

echo "Deploying rhsso instance and configuration"

# oc apply -k rhsso/overlays/myocp



