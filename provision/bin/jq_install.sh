#!/bin/bash

set -e

# set jq env vars
jq_pkg=jq
jq_url=https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64

# install jq
curl -Ls --fail -o /usr/local/bin/${jq_pkg} ${jq_url} \
  && chmod +x /usr/local/bin/${jq_pkg}
