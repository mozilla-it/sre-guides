# Installing and using Gcloud for GCP management

First, go here and get the version of gcloud that is appropriate for your environment: https://cloud.google.com/sdk/install

For example, if you use a dpkg-based system, you can run these steps:

```
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get install apt-transport-https ca-certificates gnupg
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-sdk
```

Or if you use a mac you can either grab the binary [here](https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-278.0.0-darwin-x86_64.tar.gz) or get the interactive installer [here](https://dl.google.com/dl/cloudsdk/channels/rapid/install_google_cloud_sdk.bash)

Once you've got the `gcloud` binary, run `gcloud init` to initialize your environment followed by `gcloud auth login` to authenticate against GCP (requires a web browser). Once you've completed these steps, you can ensure everything worked correctly:

```
$ gcloud auth list
                        Credentialed Accounts
ACTIVE  ACCOUNT
*       afrank@gcp.infra.mozilla.com

To set the active account, run:
    $ gcloud config set account `ACCOUNT`
```

Next you should set your project:

```
$ gcloud config set project mozilla-it-service-engineering
Updated property [core/project].
```

And you can check your config using like this:
```
$ gcloud config list
[core]
account = afrank@gcp.infra.mozilla.com
disable_usage_reporting = True
project = mozilla-it-service-engineering

Your active configuration is: [default]
```

## Talking to GCS

In addition to gcloud the SDK also comes with gsutil, which you can use for talking to GCS, Google's version of S3. You can try it out with `gsutil ls gs://`.

## Talking to a GKE cluster

```
$ gcloud container clusters list
NAME                            LOCATION  MASTER_VERSION  MASTER_IP     MACHINE_TYPE   NODE_VERSION   NUM_NODES  STATUS
mozilla-it-service-engineering  us-west1  1.15.7-gke.23   34.83.210.13  n1-standard-1  1.15.7-gke.23  6          RUNNING
```

```
$ gcloud container clusters get-credentials mozilla-it-service-engineering --region us-west1
Fetching cluster endpoint and auth data.
kubeconfig entry generated for mozilla-it-service-engineering.
```

