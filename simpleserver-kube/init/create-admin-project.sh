#!/usr/bin/env bash

echo "First read README.md"
echo "Remember to login first: gcloud auth login"
echo "First source the environment variables in ~/.gcp/"

if [ $# -ne 0 ]
then
  echo "Usage: ./create-admin-project.sh"
  exit 1
fi

# Create project.
# NOTE: This is a one time task.
# You have to set the needed TF_VAR environment variables (e.g. sourcing a bash file).

echo "*** Creating admin project... ***"
gcloud projects create $TF_VAR_ADMIN_PROJ_ID --folder=$TF_VAR_FOLDER_ID --name=$TF_VAR_ADMIN_PROJ_NAME

# Create gcloud configuration for terraform parent project.
echo "*** Creating gcloud configuration... ***"
gcloud config configurations create $TF_VAR_ADMIN_PROJ_ID
gcloud config set compute/region $TF_VAR_REGION
gcloud config set compute/zone $TF_VAR_ZONE1
gcloud config set account $TF_VAR_ACCOUNT
gcloud config set project $TF_VAR_ADMIN_PROJ_ID
gcloud config configurations list
gcloud config get-value project
# Assign billing account
#gcloud beta billing accounts list
gcloud beta billing projects link $TF_VAR_ADMIN_PROJ_ID --billing-account $TF_VAR_BILLING_ACCOUNT_ID

gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable serviceusage.googleapis.com
# Required or the Terraform service account cannot create the Kube cluster.
gcloud services enable container.googleapis.com

