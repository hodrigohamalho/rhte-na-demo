#!/usr/bin/env bash

oc delete sa,job git-watcher
oc delete bc api-management-as-code-demo
oc delete deployment threescaleapi
oc delete api api-management-as-code-demo
