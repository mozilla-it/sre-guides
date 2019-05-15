#!/bin/bash

set -u

install_ssm() {
    yum install -y amazon-ssm-agent
    systemctl start amazon-ssm-agent
}

install_lifecycled() {

    echo "${cluster_name}" > /etc/eks/cluster_name

    curl -Lf -o /usr/local/bin/graceful_shutdown.sh \
                https://gist.githubusercontent.com/limed/2486e84dcbb1098981af076011cfb8db/raw/8304c3b1e2dc89ba50380a76f61bc91892759665/lifecycled_handler.sh
    chmod +x /usr/local/bin/graceful_shutdown.sh

    # Install the binary
    curl -Lf -o /usr/bin/lifecycled \
                https://github.com/buildkite/lifecycled/releases/download/${lifecycled_version}/lifecycled-linux-amd64
    chmod +x /usr/bin/lifecycled

    curl -Lf -o /etc/systemd/system/lifecycled.service \
            https://gist.githubusercontent.com/limed/2486e84dcbb1098981af076011cfb8db/raw/8304c3b1e2dc89ba50380a76f61bc91892759665/lifecycled.unit

    touch /etc/lifecycled
    echo "AWS_REGION=${region}" > /etc/lifecycled
    echo "LIFECYCLED_SNS_TOPIC=${sns_topic}" >> /etc/lifecycled
    echo "LIFECYCLED_HANDLER=/usr/local/bin/graceful_shutdown.sh" >> /etc/lifecycled

    systemctl daemon-reload
    systemctl enable lifecycled
    systemctl start lifecycled
}

install_ssm
#install_lifecycled
