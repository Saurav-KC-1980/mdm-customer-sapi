:: This script deploys an API from an existing package
@echo off
set ENV_PROFILE=CloudHub-FINS-DEV
echo Deploying to %ENV_PROFILE%...
call mvn mule:deploy -P%ENV_PROFILE% -DmuleDeploy
echo Done.
