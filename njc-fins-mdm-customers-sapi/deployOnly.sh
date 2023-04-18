#!/bin/bash
# This script deploys an API from an existing package
#
ENV_PROFILE=CloudHub-FINS-DEV
echo Deploying to ${ENV_PROFILE}...
mvn mule:deploy -P${ENV_PROFILE} -DmuleDeploy
echo Done.