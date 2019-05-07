#!/bin/bash

lifecycled_version="v3.0.2"

sudo yum install -y amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

# Install the lifecycled binary
curl -Lf -o /usr/bin/lifecycled \
            https://github.com/buildkite/lifecycled/releases/download/$${lifecycled_version}/lifecycled-linux-amd64
chmod +x /usr/bin/lifecycled

# Install the lifecycled systemd service
# Commented out for now until we actually set this up
#touch /etc/lifecycled
#curl -Lf -o /etc/systemd/system/lifecycled.service \
#            https://raw.githubusercontent.com/buildkite/lifecycled/$${lifecycled_version}/init/systemd/lifecycled.unit

