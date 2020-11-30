locals {
  workspace_name = terraform.workspace
  module_name    = "project"
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

resource "google_project" "infra_project" {
  provider            = google
  name                = "${local.res_prefix}-${local.module_name}"
  project_id          = "${local.res_prefix}-${var.INFRA_PROJ_ID}"
  folder_id           = var.FOLDER_ID
  billing_account     = var.BILLING_ACCOUNT_ID
  auto_create_network = false

  labels = merge(local.default_labels, {
    name = "${local.res_prefix}-${local.module_name}"
  })
}

resource "google_project_service" "service" {
  provider           = google
  project            = google_project.infra_project.project_id
  disable_on_destroy = false

  for_each = toset([
    "oslogin.googleapis.com",
    # E.g. for bastion.
    "compute.googleapis.com",
    # Kubernetes (GKE) needs this.
    "container.googleapis.com",
    # If you want to list network resources.
    "networkmanagement.googleapis.com"
  ])
  service  = each.key
}

