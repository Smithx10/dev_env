#!/bin/bash

set -eo pipefail

echo "en_US ISO-8859-1" >> /etc/locale.gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen

locale-gen
