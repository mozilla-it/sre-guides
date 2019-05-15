# sre-guides
This repository contains several resources for creating Kubernetes clusters in different environments like GCP or AWS, as well as Kubernetes manifests for deploying basic components like Ingress Controlers or cluster backup solutions.

This resources are used by the IT SRE team to deploy clusters and are curated and updated.

## What's inside this repo
* [Terraform module for creating Kubernetes clusters using EKS](terraform/eks/README.md): the AWS Kubernetes-a-a-service service.
* [Terraform module for creating Kubernetes clusters in GCP](terraform/gke/README.md) using their Kubernetes-as-a-service offering.


## How to use these guides
These guides can be used to create your own cluster. There are two ways you can go:
* Clone this repository and copy the folders that match your environment.
* Fork & clean this repository leaving only what interests you.

For each specific environment or cluster component, you should be able to find a Readme file in the same folder explaining in detail how to use it. If you can't find this Readme or if the information there is outdated/incomplete/not clear, please submit an issue here and someone will take care of properly updating it.
