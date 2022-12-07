#!/bin/bash -x

export DEBIAN_FRONTEND=noninteractive

apt upgrade

apt install docker jq -y

curl -L https://carvel.dev/install.sh | K14SIO_INSTALL_BIN_DIR=/usr/local/bin/ bash

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
mv kubectl /usr/local/bin/

wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64

chmod a+x /usr/local/bin/yq

yq --version