### API Management As Code



#### Create the required secret

The secret needs to exist in some namespace where the operator has read access to. If no namesapce is provided, the operator
will attempt to read a secret in the namespace it is deployed in.

```bash
oc create secret generic demo-credentials-secret --from-literal=access_token=supersecret --from-literal=admin_portal_url=https://my-admin-portal.3scale.net
```
