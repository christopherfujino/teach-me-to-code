#!/bin/bash

if ! type fzf 1>/dev/null 2>&1; then
  echo 'This script depends on fzf being installed.'
  exit 1
fi

DRAFT=$(find _posts -name '*.md' | fzf)
EXIT="$?"
if [ "$EXIT" != 0 ]; then
  echo 'Non-zero exit.'
  exit "$EXIT"
fi

mv "$DRAFT" "_drafts/"

echo "Unpublished $DRAFT."
