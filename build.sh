#!/bin/bash

set -euo pipefail

IMAGE_NAME='teach-me-to-code/teach-me-to-code'

docker build \
  --build-arg USER_ID="$(id -u)" \
  --build-arg GROUP_ID="$(id -g)" \
  -t "$IMAGE_NAME:latest" \
  -t "$IMAGE_NAME:$(date '+%Y-%m-%d_%H%M')" \
  .
