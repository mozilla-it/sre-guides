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

variable "ssh_username" {}
variable "ssh_password" {}

output "gcp_cluster_endpoint" {
  value = "${module.gke.gcp_cluster_endpoint}"
}

output "gcp_cluster_name" {
  value = "${module.gke.gcp_cluster_name}"
}
