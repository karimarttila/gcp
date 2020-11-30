
if [ $# -ne 0 ]
then
  echo "Usage: ./init.sh"
  exit 1
fi

terraform init \
  -backend-config="bucket=${TF_VAR_TERRA_BACKEND_BUCKET_NAME}" \
  -backend-config="prefix=${TF_VAR_PREFIX}-${TF_VAR_INFRA_PROJ_ID}/project"
