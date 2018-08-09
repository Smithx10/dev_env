#!/bin/bash

set -e

# set packer env vars
packer_ver=${PACKER_VER:-1.2.4}
packer_pkg=packer_${packer_ver}_linux_amd64.zip
packer_url=https://releases.hashicorp.com/packer/${packer_ver}/${packer_pkg}
packer_sha256=$(curl -Ls --fail https://releases.hashicorp.com/packer/${packer_ver}/packer_${packer_ver}_SHA256SUMS | grep ${packer_pkg} | cut -d" " -f1)

# install packer 
curl -Ls --fail -o /tmp/${packer_pkg} ${packer_url} \
    && echo "${packer_sha256} /tmp/${packer_pkg}" | sha256sum -c \
    && unzip /tmp/${packer_pkg} -d /usr/local/bin \
    && rm /tmp/${packer_pkg}
