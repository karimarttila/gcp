output "vpc_name" {
  value = google_compute_network.vpc.name
}

output "kube_subnet_name" {
  value = google_compute_subnetwork.kube-subnetwork.name
}

output "kube_subnetwork_link" {
  value = google_compute_subnetwork.kube-subnetwork.self_link
}
