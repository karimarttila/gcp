#!/usr/bin/env bash

echo "First read README.md"
echo "First source the environment variables in ~/.gcp/"
echo "Check the actual infra project id using gcloud"

if [ $# -ne 1 ]
then
  echo "Usage: ./create-infra-configuration.sh <env>"
  exit 1
fi

MY_ENV=$1
MY_INFRA_PROJ_ID="${MY_ENV}-${TF_VAR_INFRA_PROJ_ID}"

# Create gcloud configuration for infra project.
echo "*** Creating gcloud configuration... ***"
gcloud config configurations create $MY_INFRA_PROJ_ID
gcloud config set compute/region $TF_VAR_REGION
gcloud config set compute/zone $TF_VAR_ZONE1
gcloud config set account $TF_VAR_ACCOUNT
gcloud config set project $MY_INFRA_PROJ_ID
gcloud config configurations list
gcloud config get-value project

