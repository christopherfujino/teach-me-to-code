#!/bin/bash

if ! type fzf 1>/dev/null 2>&1; then
  echo 'This script depends on fzf being installed.'
  exit 1
fi

DRAFT=$(find _drafts -name '*.md' | fzf)
EXIT="$?"
if [ "$EXIT" != 0 ]; then
  echo 'Non-zero exit.'
  exit "$EXIT"
fi

mv "$DRAFT" "_posts/"

echo "Published $DRAFT."
