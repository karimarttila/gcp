locals {
  workspace_name = terraform.workspace
  module_name    = "kube"
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

resource "google_container_cluster" "kube-cluster" {
  name                     = "${local.res_prefix}-${local.module_name}-cluster"
  location                 = var.REGION
  project                  = data.terraform_remote_state.project.outputs.project_id
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = data.terraform_remote_state.vpc.outputs.vpc_name
  subnetwork               = data.terraform_remote_state.vpc.outputs.kube_subnet_name

  master_auth {
    username = var.GKE_USERNAME
    password = var.GKE_PASSWORD

    client_certificate_config {
      issue_client_certificate = false
    }
  }
}

resource "google_container_node_pool" "kube_nodes" {
  name       = "${google_container_cluster.kube-cluster.name}-node-pool"
  location   = var.REGION
  cluster    = google_container_cluster.kube-cluster.name
  node_count = var.gke_nodes
  project    = data.terraform_remote_state.project.outputs.project_id

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]

    labels = merge(local.default_labels, {
      name = "${local.res_prefix}-${local.module_name}-kube-nodes"
    })
  }
}
