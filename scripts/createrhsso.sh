oc apply -f https://raw.githubusercontent.com/openshift/library/master/official/sso/imagestreams/sso74-openshift-rhel8.json -n openshift
oc apply -f https://raw.githubusercontent.com/openshift/library/master/official/sso/templates/sso74-x509-postgresql-persistent.json -n openshift
oc new-project sso
oc new-app sso74-x509-postgresql-persistent -p SSO_ADMIN_USERNAME=admin -p SSO_ADMIN_PASSWORD=password -n sso

