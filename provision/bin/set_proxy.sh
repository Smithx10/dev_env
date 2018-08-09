#!/bin/bash

set -eo pipefail

####################
#    VARIABLES     #
####################

PROVISION_DIR="/tmp/provision"

####################
#       MAIN       #
####################

if curl -L github.com | grep "Web Page Blocked"; then
  echo "We are behind the Corporate Proxy, Setting http_proxy"
  export http_proxy=${ONPREMISE_HTTP_PROXY}
  export https_proxy=${ONPREMISE_HTTPS_PROXY}
  echo "HTTP proxy defined with ${ONPREMISE_HTTP_PROXY}"
  echo "HTTPS proxy defined with ${ONPREMISE_HTTPS_PROXY}"
fi
