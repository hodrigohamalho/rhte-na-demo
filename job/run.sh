#!/usr/bin/env bash

function getSha() {
	curl -s https://api.github.com/repos/jmprusi/rhte-na-demo/commits/master | jq .'sha'
}

function startBuild() {
	curl -s -k -X POST -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
		-H 'content-type: application/json;charset=UTF-8' -H 'accept: application/json, text/plain, */*' \
		--data-binary '{"kind":"BuildRequest","apiVersion":"build.openshift.io/v1","metadata":{"name":"'${BUILD_NAME}'"}}' \
  		https://kubernetes.default/apis/build.openshift.io/v1/namespaces/${NAMESPACE}/buildconfigs/${BUILD_NAME}/instantiate
}

startBuild
sha=$(getSha)
sleep 5;

while true; do

  latest_sha=$(getSha)

  if [ $latest_sha != $sha ]; then
  	echo "Start the build"
	startBuild
  else
  	echo "Nothing to do"
  fi

  sha=$latest_sha
  sleep 5;

done




