#!/bin/bash

set -euo pipefail

docker build -t teach-me-to-code/teach-me-to-code:latest .
docker run \
  -it \
  --rm \
  --volume="$PWD:/srv/jekyll" \
  -p 4000:4000 \
  teach-me-to-code/teach-me-to-code:latest
  #--mount type=bind,src="$PWD",dst=/srv/jekyll/blog \
