#!/usr/bin/env bash

echo "First read README.md"
echo "First source the environment variables in ~/.gcp/"

if [ $# -ne 0 ]
then
  echo "Usage: ./create-admin-bucket.sh"
  exit 1
fi

# Make Cloud storage bucket.
echo "*** Creating bucket for terraform backend... ***"

gsutil mb -p ${TF_VAR_ADMIN_PROJ_ID} -c regional -l ${TF_VAR_REGION} gs://${TF_VAR_TERRA_BACKEND_BUCKET_NAME}
gsutil versioning set on gs://${TF_VAR_TERRA_BACKEND_BUCKET_NAME}

