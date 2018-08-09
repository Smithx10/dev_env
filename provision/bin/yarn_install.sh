#!/bin/bash

set -eo pipefail

PROVISION_DIR=/tmp/provision

installPkgs() {
  if curl -L github.com | grep "Web Page Blocked"; then
    echo "We are behind the Corporate Proxy, Setting http_proxy"
    yarn config set proxy http://${ONPREMISE_HTTP_PROXY}
    yarn config set https-proxy http://${ONPREMISE_HTTPS_PROXY}
  fi

  yarn global add \
    sshp \
    json
}

main() {
    installPkgs
}
main
