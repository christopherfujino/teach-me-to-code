#!/usr/bin/env bash

set -xeuo pipefail

HUGO="$PWD/third_party/bin/hugo"

rm -f "$HUGO"

pushd third_party/hugo
  go build -tags extended -o "$HUGO" .
popd

pushd blog
  "$HUGO" serve --port 1313 &
  SERVER_PID=$!
  echo "SERVER_PID forked at $SERVER_PID"
  sleep 1
  set +e
  OUT=$(curl -L http://localhost:1313/recommendations | grep 'sustainable social media')
  CODE=$?
  set -e
  echo "Received: $OUT"
  echo "with code $CODE"
  kill "$SERVER_PID"
popd
