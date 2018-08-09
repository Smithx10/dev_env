#!/bin/bash

set -eo pipefail

PROVISION_DIR=/tmp/provision
source ${PROVISION_DIR}/bin/set_proxy.sh

addUser() {
    useradd ${USERNAME} -m
    echo "bruce ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
}

installYaourt() {
    git clone https://aur.archlinux.org/package-query.git
    cd package-query
    chmod 777 ./
    su bruce -c 'makepkg -si --noconfirm'
    cd ..
    git clone https://aur.archlinux.org/yaourt.git
    cd yaourt
    chmod 777 ./
    su bruce -c 'makepkg -si --noconfirm'
    cd ..
}

main() {
    addUser
    installYaourt
}
main
