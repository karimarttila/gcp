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
    # NOTE: and echo $TF_VAR_INFRA_PROJ_ID
    # NOTE ***********************************************************************************************
    # $TF_VAR_TERRA_BACKEND_BUCKET_NAME
    bucket = "kari-kube-terraform-2"
    # $TF_VAR_INFRA_PROJ_ID/module/terraform.tfstate
    prefix = "kari-kube-id-8/kube"
  }
}

data "terraform_remote_state" "project" {
  backend   = "gcs"
  workspace = terraform.workspace
  config    = {
    bucket = var.TERRA_BACKEND_BUCKET_NAME
    prefix = "kari-kube-id-8/project"
  }
}

data "terraform_remote_state" "vpc" {
  backend   = "gcs"
  workspace = terraform.workspace
  config    = {
    bucket = var.TERRA_BACKEND_BUCKET_NAME
    prefix = "kari-kube-id-8/vpc"
  }
}
