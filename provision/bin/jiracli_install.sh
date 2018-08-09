#!/bin/bash

set -eo pipefail

# set jiracli env vars
jira_ver=1.0.20
jira_name=jira
jira_pkg=${jira_name}-linux-amd64
jira_url=https://github.com/Netflix-Skunkworks/go-jira/releases/download/v${jira_ver}/${jira_pkg}

# install jiracli
curl -Ls --fail -o /usr/local/bin/${jira_name} ${jira_url} \
  && chmod +x /usr/local/bin/${jira_name} \
  && mkdir -p ~/.jira.d \
  && cp /tmp/provision/etc/jira_config.yaml ~/.jira.d/config.yaml
