#!/bin/bash

echo "These are the environment variables for the TODO-NAME folder!"

echo "Use source!"
echo "You have to use unique IDs for project. In GCP any project id that has ever been used cannot be used again! Use GCP_DEPL_VERSION to define new unique id."

# Example: pekka
export TF_VAR_OWNER=TODO
# Example: pekka-kube1
export TF_VAR_PROJECT=TODO-TODO


# NOTE: Remember also to change the bucket name in your terraform GCP backend configuration...
# ... it is hard-coded there since no variables are allowed in that section.
export GCP_ADMIN_VERSION=tmp-1
export GCP_INFRA_VERSION=tmp-1

export TF_VAR_ADMIN_PROJ_ID=TODO-TODO-parent-id-$GCP_ADMIN_VERSION
export TF_VAR_CREDS=~/.config/gcloud/${USER}-terraform-${TF_VAR_ADMIN_PROJ_ID}.json
export TF_VAR_ADMIN_PROJ_NAME=TODO-TODO-terraform-parent
export TF_VAR_TERRA_BACKEND_BUCKET_NAME=TODO-TODO-terraform-$GCP_ADMIN_VERSION
export TF_VAR_INFRA_PROJ_ID=TODO-TODO-id-$GCP_INFRA_VERSION
export TF_VAR_INFRA_PROJ_NAME=TODO-TODO
export TF_VAR_FOLDER_ID=
export TF_VAR_ORG_ID=
export TF_VAR_BILLING_ACCOUNT_ID=
export TF_VAR_REGION=europe-north1
export TF_VAR_ZONE1=europe-north1-a
export TF_VAR_ZONE2=europe-north1-b
export TF_VAR_ZONE3=europe-north1-c
export TF_VAR_ACCOUNT=

export GOOGLE_APPLICATION_CREDENTIALS=${TF_VAR_CREDS}
export GOOGLE_PROJECT=${TF_VAR_ADMIN_PROJ_ID}

echo "TF_VAR_ADMIN_PROJ_ID: $TF_VAR_ADMIN_PROJ_ID"
echo "TF_VAR_ADMIN_PROJ_NAME: $TF_VAR_ADMIN_PROJ_NAME"
echo "TF_VAR_TERRA_BACKEND_BUCKET_NAME: $TF_VAR_TERRA_BACKEND_BUCKET_NAME"
echo "TF_VAR_INFRA_PROJ_ID: $TF_VAR_INFRA_PROJ_ID"
echo "TF_VAR_INFRA_PROJ_NAME: $TF_VAR_INFRA_PROJ_NAME"
echo "TF_VAR_FOLDER_ID: $TF_VAR_FOLDER_ID"
echo "TF_VAR_CONFIG_NAME: $TF_VAR_CONFIG_NAME"
# Do not list these in demos:
#echo "TF_VAR_FOLDER_ID: $TF_VAR_FOLDER_ID"
#echo "TF_VAR_ORG_ID: $TF_VAR_ORG_ID"
#echo "TF_VAR_BILLING_ACCOUNT_ID: $TF_VAR_BILLING_ACCOUNT_ID"

#echo "List configurations:"
#gcloud config configurations list

