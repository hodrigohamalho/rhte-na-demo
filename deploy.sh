#!/usr/bin/env bash

echo "Creating Service Account with required permissions"
oc create -f ./job/job_sa.yaml
oc policy add-role-to-user edit -z git-watcher


echo "Creating Jenkins Pipeline and deploying Operator"
oc new-app -f ./job/job_tmpl.yaml -p BUILD_NAME=api-management-as-code-demo


# FIXME

oc adm policy  --as system:admin add-cluster-role-to-user cluster-admin system:serviceaccount:myproject:jenkins
oc adm policy  --as system:admin add-cluster-role-to-user cluster-admin system:serviceaccount:myproject:default
