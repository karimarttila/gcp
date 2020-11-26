locals {
  workspace_name = terraform.workspace
  module_name    = "vpc"
  res_prefix     = "${var.PREFIX}-${local.workspace_name}"
  default_labels = {
    resprefix = local.res_prefix
    prefix    = var.PREFIX
    workspace = terraform.workspace
    module    = local.module_name
    region    = var.REGION
    zone      = var.ZONE1
    owner     = var.OWNER
    project   = var.PROJECT
    terraform = "true"
  }
}

resource "google_compute_network" "vpc" {
  name                    = "${local.res_prefix}-${local.module_name}"
  auto_create_subnetworks = false
  project                 = data.terraform_remote_state.project.outputs.project_id
}

resource "google_compute_subnetwork" "kube-subnetwork" {
  name          = "${local.res_prefix}-kube-subnetwork"
  ip_cidr_range = var.kube_subnet_cidr_block
  network       = google_compute_network.vpc.self_link
  region        = var.REGION
  project       = data.terraform_remote_state.project.outputs.project_id
}

