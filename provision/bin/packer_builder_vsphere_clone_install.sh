#!/bin/bash

set -e

# set packer builder vsphere clone env vars
pbvc_ver=${PBVC_VER:-2.0}
pbvc_pkg=packer-builder-vsphere-clone.linux
pbvc_url=https://github.com/jetbrains-infra/packer-builder-vsphere/releases/download/v${pbvc_ver}/${pbvc_pkg}
pbvc_sha256=c0ff2e3a008282215524828007e4a3479ff807db48519a8a9817a68656ad5645
pbvc_path=/usr/local/bin/packer-builder-vsphere-clone

# install packer builder vsphere clone
curl -Ls --fail -o ${pbvc_path} ${pbvc_url} \
    && echo "${pbvc_sha256} ${pbvc_path}" | sha256sum -c \
    && chmod +x ${pbvc_path}
