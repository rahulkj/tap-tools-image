#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

apt upgrade

install_jq() {
    echo "installing jq"
    apt install jq -y
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
    wget -qO /usr/local/bin/yq https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64

    chmod a+x /usr/local/bin/yq

    yq --version
}

install_docker() {
    echo "installing docker"
    apt-get install \
        ca-certificates \
        curl \
        gnupg \
        lsb-release -y

    mkdir -p /etc/apt/keyrings

    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update

    apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
}

install_yq
install_carvel
install_kubectl
install_yq
install_docker