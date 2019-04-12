variable "project_id" {
  default = "imposing-union-227917"
}

variable "cluster_name" {
  default = "afrank-test-cluster-0"
}

variable "region" {
  default = "us-west1"
}

variable "creds-file" {
  default = "creds/imposing-union-227917.json"
}

output "gcp_cluster_endpoint" {
    value = "${google_container_cluster.gcp_kubernetes.endpoint}"
}

output "gcp_cluster_name" {
    value = "${google_container_cluster.gcp_kubernetes.name}"
}
