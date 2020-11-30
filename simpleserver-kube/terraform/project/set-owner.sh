#!/usr/bin/env bash

if [ $# -ne 1 ]
then
  echo "Usage: ./set-owner.sh <terraform-workspace>"
  echo "NOTE: <terraform-workspace> is default, dev, qa..."
  exit 1
fi

MY_ENV=$1
gcloud config configurations activate "${TF_VAR_PREFIX}-${MY_ENV}-${TF_VAR_INFRA_PROJ_ID}"
gcloud projects add-iam-policy-binding "${TF_VAR_PREFIX}-${MY_ENV}-${TF_VAR_INFRA_PROJ_ID}" --member "user:${TF_VAR_ACCOUNT}" --role "roles/owner"
gcloud projects describe "${TF_VAR_PREFIX}-${MY_ENV}-${TF_VAR_INFRA_PROJ_ID}"


