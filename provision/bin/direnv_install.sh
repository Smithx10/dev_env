#!/bin/bash

set -eo pipefail

PROVISION_DIR=/tmp/provision
source ${PROVISION_DIR}/bin/set_proxy.sh

installDirEnv() {
    git clone https://github.com/direnv/direnv
    cd direnv
    make
    make install
}

main() {
   installDirEnv
}
main
