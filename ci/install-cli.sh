#!/bin/bash -x

export DEBIAN_FRONTEND=noninteractive

apt upgrade

apt install kubectl docker jq yq 

curl -L https://carvel.dev/install.sh | K14SIO_INSTALL_BIN_DIR=/usr/local/bin/ bash