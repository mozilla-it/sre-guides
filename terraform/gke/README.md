# gke installation example

1. Get your project ID.
2. Create a GCP service account key:
  * login to the google cloud dashboard.
  * navigate to "Service Accounts" in IAM/Admin
  * Create a new service account or click the 3 dots next to an existing one, and click "Create key".
  * DO NOT CHECK THIS JSON FILE INTO GIT!
3. Install gcloud and set up your environment:
  * `gcloud auth login`
  * `gcloud config set project <my-project-id>`
  * `export GOOGLE_APPLICATION_CREDENTIALS=<path-to-your-key-json-file>`
4. Create a bucket to store your terraform state.
```
gcloud gs mb gs://itsre-state-${accountId}
```
5. Update/create a `terraform.tfvars` file and ensure the following keys are set properly:
```
project_id = <my-project-id>
cluster_name = <my-made-up-cluster-name>
region = <my-region> # default us-west1
creds-file = <path-to-my-json-key-file>
ssh_username = <my-made-up-ssh-username>
ssh_password = <my-made-up-ssh-password>
```
5. Update the bucket/key references in the `terraform {}` section of `main.tf`. This can't be done with a variable. Sorry.
6. terraform 
   * terraform init
   * terraform plan
   * terraform apply

Read more about terraform conventions [here](https://mana.mozilla.org/wiki/display/SRE/Terraform)
