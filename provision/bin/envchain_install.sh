#!/bin/bash

set -eo pipefail

PROVISION_DIR=/tmp/provision
source ${PROVISION_DIR}/bin/set_proxy.sh

installEnvChain() {
    git clone https://github.com/sorah/envchain
    cd envchain
    make
    make install
}

main() {
    installEnvChain
}
main
