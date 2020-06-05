tlscert=`oc get secrets/router-certs -o jsonpath={.data.'tls\.crt'} -n openshift-ingress | base64 --decode`
oc delete configmap openidcacrt -n openshift-config
oc create configmap openidcacrt --from-literal ca.crt="$tlscert" -n openshift-config
