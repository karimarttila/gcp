#!/bin/bash

echo "These are the environment variables for the TODO-NAME folder!"

echo "Use source!"
echo "You have to use unique IDs for project. In GCP any project id that has ever been used cannot be used again! Use GCP_DEPL_VERSION to define new unique id."


# Example: pekka, harri... For administration purposes - used in resource labels.
export TF_VAR_OWNER=TODO
# Example: projx, projy etc. For administration purposes - used in resource labels.
export TF_VAR_PROJECT=TODO

# Example: kubekari, used in resource names. Should be unique per GCP account.
export TF_VAR_PREFIX=TODO
# NOTE: You can also use terraform workspaces - the workspace name is appended to the resource names with prefix
# and workspaces are stored in dedicated terraform states.
# Workspaces can be e.g. "dev" or "qa", therefore the resource names would be "projx-dev", "projx-qa" etc.

# NOTE: Remember also to change the bucket name in your terraform GCP backend configuration...
# ... it is hard-coded there since no variables are allowed in that section.
# Using incremental values here since you cannot re-create a GCP project with the same id.
export GCP_ADMIN_VERSION=1
export GCP_INFRA_VERSION=1

export TF_VAR_ADMIN_PROJ_ID=TODO-parent-id-$GCP_ADMIN_VERSION
export TF_VAR_CREDS=~/.config/gcloud/${USER}-terraform-${TF_VAR_ADMIN_PROJ_ID}.json
export TF_VAR_ADMIN_PROJ_NAME=TODO-terraform-parent
export TF_VAR_TERRA_BACKEND_BUCKET_NAME=TODO-terraform-$GCP_ADMIN_VERSION
export TF_VAR_INFRA_PROJ_ID=$GCP_INFRA_VERSION
export TF_VAR_INFRA_PROJ_NAME=TODO
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

export TF_VAR_GKE_USERNAME=TODO
export TF_VAR_GKE_PASSWORD=TODO

echo "TF_VAR_PREFIX: $TF_VAR_PREFIX"
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

