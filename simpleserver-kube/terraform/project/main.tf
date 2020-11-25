locals {
  workspace_name = terraform.workspace == "default" ? "" : "-${terraform.workspace}"
  module_name    = "project"
  res_prefix     = "${var.prefix}${local.workspace_name}"
  default_labels = {
    resprefix = local.res_prefix
    prefix    = var.prefix
    workspace = terraform.workspace
    module    = local.module_name
    region    = var.REGION
    zone      = var.ZONE1
    terraform = "true"
  }
}

resource "google_project" "infra_project" {
  provider            = google
  name                = var.INFRA_PROJ_NAME
  project_id          = var.INFRA_PROJ_ID
  folder_id           = var.FOLDER_ID
  billing_account     = var.BILLING_ACCOUNT_ID
  auto_create_network = false

  labels = merge(local.default_labels, {
    name = "${local.res_prefix}-${local.module_name}"
  })
}


resource "google_project_service" "service" {
  project = google_project.infra_project.project_id
  disable_on_destroy = false

  for_each = toset([
    "oslogin.googleapis.com",
    "compute.googleapis.com"
  ])
  service = each.key
}