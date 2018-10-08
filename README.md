### API Management As Code


                                                                                           ^
                                                                                           |
       +-------------------------+                   +-------------------------+           |
       |                         |                   |                         |           |Reacts
       |                         |                   |                         |           |
       |                         |                   |                         |           |
       |                         |                   |                         |           |
       |     OpenShift Job       | +---------------> |       Git Repo          |   +-------+------+
       |                         |      Watches      |                         |   |              |
       |                         |                   |                         |   |              |
       |                         |                   |                         |   |              |
       |                         |                   |                         |   |              |
       +-------------------------+                   +-------------------------+   |              |
                    +                                                              |              |
                    |                                                              |   Operator   |
                    | Triggers                                                     |              |
                    |                                                              |              |
                    v                                                              |              |
       +-------------------------+                   +-------------------------+   |              |
       |                         |                   |                         |   |              |
       |                         |                   |                         |   |              |
       |                         |                   |                         |   +--------------+
       |                         |Applies changes to |                         |           ^
       |     Jenkins Pipeline    |                   |           CRD           |           |
       |                         |+----------------> |                         |           |
       |                         |                   |                         |           |
       |                         |                   |                         |+----------+
       |                         |                   |                         |   Picks up event
       +-------------------------+                   +-------------------------+

#### Create the required secret

The secret needs to exist in some namespace where the operator has read access to. If no namesapce is provided, the operator
will attempt to read a secret in the namespace it is deployed in.

```bash
oc create secret generic demo-credentials-secret --from-literal=access_token=supersecret --from-literal=admin_portal_url=https://my-admin-portal.3scale.net
```


#### Create BuildConfig and Job

The `deploy.sh` script in the root of this repository does the following:

1. Creates a Service Account which is used by the Job
1. Adds required permissions to the Service Account
1. Createsa BuildConfig with buildname `api-management-as-code-demo` and a Job to watch for changes to this repo.
