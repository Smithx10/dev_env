#!/bin/bash

set -e

# set cfgt env vars
cfgt_ver=${CFGT_VER:-1.0.0}
cfgt_pkg=cfgt_linux_amd64.tar.gz
cfgt_url=https://github.com/sean-/cfgt/releases/download/v${cfgt_ver}/${cfgt_pkg}
cfgt_sha256=874893b8d0be66fcc64e07e2d351e7aabbcc41be2ab8fc8beb8b737884de214c

# install cfgt
curl -Ls --fail -o /tmp/${cfgt_pkg} ${cfgt_url} \
    && echo "${cfgt_sha256} /tmp/${cfgt_pkg}" | sha256sum -c \
    && tar zxvf /tmp/${cfgt_pkg} -C /usr/local/bin \
    && rm /tmp/${cfgt_pkg}

