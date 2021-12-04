#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

IFS=$'\n'
CHARTS=($(ct lsc))

for i in "${CHARTS[@]}"; do
  helm package $i
done

for j in *.tgz; do
  helm push-artifactory $j mammut-helm
done