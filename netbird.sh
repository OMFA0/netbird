#!/bin/bash

set -e

if test $(ubnt-device-info firmware) \< "3.0.0"; then
    echo "Try the other UDM setup script for 1.x: https://git.shivering-isles.com/-/snippets/19" >&2
    exit 1
fi

mkdir -p /data/netbird

cd /data/netbird

if [[ -e ./netbird ]]; then
    mv ./netbird ./netbird.old
fi

NETBIRD_VERSION="$(curl -s https://api.github.com/repos/netbirdio/netbird/releases/latest | jq -r ".tag_name")"
curl -L https://github.com/netbirdio/netbird/releases/download/${NETBIRD_VERSION}/netbird_${NETBIRD_VERSION//v}_linux_arm64.tar.gz | tar xvzf -

./netbird service install || true # ignore error since it'll fail if it's already installed

# Due to outdated kernels by unifi, this is required otherwise newer versions of netbird fail to start
mkdir -p /etc/systemd/system/netbird.service.d/
cat >/etc/systemd/system/netbird.service.d/legacy.conf <<EOF
[Service]
Environment="NB_USE_LEGACY_ROUTING=true"
Environment="NB_DISABLE_CUSTOM_ROUTING=true"
EOF

systemctl daemon-reload

if systemctl is-active netbird.service; then
    systemctl restart netbird.service
fi

if ! systemctl is-enabled netbird.service; then
    systemctl enable --now netbird.service
fi
