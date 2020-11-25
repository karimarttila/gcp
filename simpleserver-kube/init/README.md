# Order of Actions

1. gcloud auth login
2. Copy-paste env-vars-template.sh to ~/.gcp/YOUR-PROJ-env-vars.sh
3. Provide the values in ~/.gcp/YOUR-PROJ-env-vars.sh
4. ./create-admin-project.sh
5. ./create-service-account.sh
6. ./create-admin-bucket.sh
7. ./create-infra-configuration.sh

**NOTE:** We don't create the infra project here - we create it as part of the Terraform solution.

When running various environments change the `TF_VAR_prefix` environment variable, e.g.:
```bash
export TF_VAR_prefix=dev
```