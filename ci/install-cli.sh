#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
export OUTPUT=/usr/local/bin

REPO_YQ=mikefarah/yq
REPO_KP=buildpacks-community/kpack-cli

apt upgrade

get_latest_release() {
    DOWNLOAD_URL=$(curl -L --silent "https://api.github.com/repos/$1/releases/latest" | \
      jq -r \
      --arg flavor $2 '.assets[] | select(.name | contains($flavor)) | .browser_download_url')
}

install_jq() {
    echo 'Installing jq'
    apt install -y jq
    echo "jq cli:" $(jq --version)
}

install_carvel() {
    echo "installing carvel tools"
    curl -L https://carvel.dev/install.sh | K14SIO_INSTALL_BIN_DIR=/usr/local/bin bash
}

install_kubectl() {
    echo "installing kubectl"
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

    chmod +x kubectl
    mv kubectl /usr/local/bin/
}

install_yq() {
    echo "installing yq"
    get_latest_release "$REPO_YQ" "linux_amd64"

    while read -r line; do
      if [[ "$line" != *.tar.gz ]]; then
        wget -qO "$OUTPUT"/yq "$line"
        chmod +x "$OUTPUT"/yq
      fi
    done <<< "$DOWNLOAD_URL"

    echo "yq cli:" $(yq --version)
}

install_kp() {
    echo 'Installing kp'

    get_latest_release "$REPO_KP" "linux-amd64"

    while read -r line; do
        wget -qO "$OUTPUT"/kp "$line"
        chmod +x "$OUTPUT"/kp
    done <<< "$DOWNLOAD_URL"

    echo "kq cli:" $(kq version)
}

install_docker() {
    echo "installing docker"
    apt install docker.io -y
}

install_jq
install_yq
install_kp
install_carvel
install_kubectl
install_docker