provider "google" {
  version     = "3.49.0"
  project     = "${local.res_prefix}-${var.INFRA_PROJ_ID}"
  credentials = file(var.CREDS)
  region      = var.REGION
}

provider "google-beta" {
  version     = "3.49.0"
  project     = "${local.res_prefix}-${var.INFRA_PROJ_ID}"
  credentials = file(var.CREDS)
  region      = var.REGION
}

terraform {
  required_version = ">=0.13.4"
  backend "gcs" {
    # NOTE ***********************************************************************************************
    # NOTE: Change here the bucket name that you use to store Terraform backend.
    # NOTE: Variables not allowed here, therefore check it: echo $TF_VAR_TERRA_BACKEND_BUCKET_NAME
    # NOTE ***********************************************************************************************
    # $TF_VAR_TERRA_BACKEND_BUCKET_NAME
    bucket = "kari-kube-terraform-2"
    prefix = "kari-kube-id-8/project"
  }
}