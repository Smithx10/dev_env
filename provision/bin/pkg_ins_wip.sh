#!/bin/bash

set -eo pipefail

PROVISION_DIR=/tmp/provision
source ${PROVISION_DIR}/bin/set_proxy.sh

configureLocale(){
    echo "en_US ISO-8859-1" >> /etc/locale.gen
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
}

installPkgs() {
    pacman -Sy --noconfirm \
            base-devel \
            unzip \
            git \
            zsh \
            neovim \
            openssh \
            tmux \
            go \
            yajl \
            aws-cli \
            bind-tools \
            python \
            python-pip \
            openssl-1.0 \
            nodejs \
            npm \
            yarn \
            cmake \
    && pip install \
            neovim \
            httpie
}

main() {
    configureLocale
    installPkgs
}
main
