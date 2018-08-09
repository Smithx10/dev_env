#!/bin/bash

set -eo pipefail

PROVISION_DIR=/tmp/provision
source ${PROVISION_DIR}/bin/set_proxy.sh

installTpm() {
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

main() {
  installTpm 
}
main
