#!/bin/bash

audisp_version="2.2.2-1"
lifecycled_version="v3.0.2"

aws s3 cp --recursive s3://audisp-json/ /tmp
sudo rpm -i /tmp/audisp-json-$${audisp_version}.amazonlinux_x86_64.rpm
sudo mv /tmp/audit.rules /etc/audit/rules.d/
sudo service auditd restart
sudo yum install -y amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

# Install the lifecycled binary
curl -Lf -o /usr/bin/lifecycled \
            https://github.com/buildkite/lifecycled/releases/download/$${lifecycled_version}/lifecycled-linux-amd64
chmod +x /usr/bin/lifecycled

# Install the lifecycled systemd service
touch /etc/lifecycled
curl -Lf -o /etc/systemd/system/lifecycled.service \
            https://raw.githubusercontent.com/buildkite/lifecycled/$${lifecycled_version}/init/systemd/lifecycled.unit

