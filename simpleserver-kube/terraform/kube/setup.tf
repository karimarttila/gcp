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

# NOTE: Initialize terraform backend with init.sh script!
terraform {
  required_version = ">=0.13.4"
  backend "gcs" {
  }
}

data "terraform_remote_state" "project" {
  backend   = "gcs"
  workspace = terraform.workspace
  config    = {
    bucket = var.TERRA_BACKEND_BUCKET_NAME
    prefix = "${var.PREFIX}-${var.INFRA_PROJ_ID}/project"
  }
}

data "terraform_remote_state" "vpc" {
  backend   = "gcs"
  workspace = terraform.workspace
  config    = {
    bucket = var.TERRA_BACKEND_BUCKET_NAME
    prefix = "${var.PREFIX}-${var.INFRA_PROJ_ID}/vpc"
  }
}

