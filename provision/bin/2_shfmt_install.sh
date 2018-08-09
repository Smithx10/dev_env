#!/bin/bash

set -eo pipefail

# set shfmt env vars
PROVISION_DIR=/tmp/provision
source ${PROVISION_DIR}/bin/set_proxy.sh

shfmt_ver=2.5.1
shfmt_name=shfmt_v${shfmt_ver}
shfmt_pkg=${shfmt_name}_linux_amd64
shfmt_url=https://github.com/mvdan/sh/releases/download/v${shfmt_ver}/${shfmt_pkg}
# install shfmt
curl -Ls --fail -o /usr/local/bin/shfmt ${shfmt_url} \
  && chmod +x /usr/local/bin/shfmt
