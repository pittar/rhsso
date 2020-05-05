SSO_HOST=https://`oc get route/sso -o jsonpath={.spec.host} -n sso`
retrieve_token_url=$SSO_HOST/auth/realms/master/protocol/openid-connect/token


TKN=$(curl -X POST "$retrieve_token_url" -k \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -d "username=admin" \
            -d "password=password" \
            -d "grant_type=password" \
            -d "client_id=admin-cli" \
            | sed 's/.*access_token":"//g' | sed 's/".*//g')


curl -v -X POST -k \
  -H "Authorization: Bearer $TKN" \
  -H "Content-Type: application/json" \
  -d @realm.json \
  $SSO_HOST/auth/admin/realms

