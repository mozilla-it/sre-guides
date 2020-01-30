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


