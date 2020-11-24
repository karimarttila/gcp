#!/usr/bin/env bash

echo "First read README.md"
echo "First source the environment variables in ~/.gcp/"
echo "NOTE: choose the admin project configuration before running this script"
if [ $# -ne 0 ]
then
  echo "Usage: ./create-service-account.sh"
  exit 1
fi

# Create service account.
# NOTE: This is a one time task.
# You have to set the needed TF_VAR environment variables (e.g. sourcing a bash file).

SA_NAME=terraform@${TF_VAR_ADMIN_PROJ_ID}.iam.gserviceaccount.com

echo "*** Creating service account... ***"
gcloud iam service-accounts create terraform \
    --description "Service account to be used with $TF_VAR_ADMIN_PROJ_NAME project" \
    --display-name "Terraform SA $TF_VAR_ADMIN_PROJ_NAME"

gcloud iam service-accounts keys create ${TF_VAR_CREDS} \
  --iam-account $SA_NAME

gcloud projects add-iam-policy-binding ${TF_VAR_ADMIN_PROJ_ID} \
  --member serviceAccount:${SA_NAME} \
  --role roles/viewer

gcloud projects add-iam-policy-binding ${TF_VAR_ADMIN_PROJ_ID} \
  --member serviceAccount:${SA_NAME} \
  --role roles/storage.admin

gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable cloudbilling.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable serviceusage.googleapis.com


gcloud organizations add-iam-policy-binding ${TF_VAR_ORG_ID} \
  --member serviceAccount:${SA_NAME} \
  --role roles/resourcemanager.projectCreator

gcloud organizations add-iam-policy-binding ${TF_VAR_ORG_ID} \
  --member serviceAccount:${SA_NAME} \
  --role roles/billing.user

gcloud alpha resource-manager folders \
  add-iam-policy-binding $TF_VAR_FOLDER_ID \
  --member=serviceAccount:$SA_NAME \
  --role roles/resourcemanager.projectCreator

gcloud alpha resource-manager folders \
  add-iam-policy-binding $TF_VAR_FOLDER_ID \
  --member=serviceAccount:$SA_NAME \
  --role=roles/resourcemanager.folderEditor

gcloud alpha resource-manager folders \
  add-iam-policy-binding $TF_VAR_FOLDER_ID \
  --member=serviceAccount:$SA_NAME \
  --role=roles/editor

