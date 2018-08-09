#!/bin/bash

set -e

# set packer builder vpshere iso oenv vars
pbvi_ver=${PBVI_VER:-2.0}
pbvi_pkg=packer-builder-vsphere-iso.linux
pbvi_url=https://github.com/jetbrains-infra/packer-builder-vsphere/releases/download/v${pbvi_ver}/${pbvi_pkg}
pbvi_sha256=fa7665e91ea7f7ee8011c13322f44c84e8d6ac361f2fc3b08f61e1988d90a740
pbvi_path=/usr/local/bin/packer-builder-vsphere-iso


# install packer builder vsphere iso
curl -Ls --fail -o ${pbvi_path} ${pbvi_url} \
    && echo "${pbvi_sha256} ${pbvi_path}" | sha256sum -c \
    && chmod +x ${pbvi_path}
