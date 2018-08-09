#!/bin/bash

set -e

# set terraform env vars
tf_ver=${TF_VER:-0.11.7}
tf_pkg=terraform_${tf_ver}_linux_amd64.zip
tf_url=https://releases.hashicorp.com/terraform/${tf_ver}/${tf_pkg}
tf_sha256=$(curl -Ls --fail https://releases.hashicorp.com/terraform/{$tf_ver}/terraform_${tf_ver}_SHA256SUMS | grep ${tf_pkg} | cut -d" " -f1)

# install terraform 
curl -Ls --fail -o /tmp/${tf_pkg} ${tf_url} \
    && echo "${tf_sha256} /tmp/${tf_pkg}" | sha256sum -c \
    && unzip /tmp/${tf_pkg} -d /usr/local/bin \
    && rm /tmp/${tf_pkg}
