#!/usr/bin/env bash

echo "First read README.md"
echo "Remember to login first: gcloud auth login"
echo "First source the environment variables in ~/.gcp/"


if [ $# -ne 1 ]
then
  echo "Usage: ./create-infra-project.sh <env>"
  exit 1
fi

MY_ENV=$1

# Create project.
# NOTE: This is a one time task.
# You have to set the needed TF_VAR environment variables (e.g. sourcing a bash file).
gcloud projects create ${MY_ENV}-${TF_VAR_INFRA_PROJ_ID} --folder=${TF_VAR_FOLDER_ID} --name=${MY_ENV}-${TF_VAR_INFRA_PROJ_NAME}"
