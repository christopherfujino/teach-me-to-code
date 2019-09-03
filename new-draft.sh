#!/bin/bash

# takes in path
create_file() {
  DIR=$1
  TITLE=$2
  FILENAME="$DIR/$(date +%F)-$2.md"

  FRONTMATTER='---\n'
  FRONTMATTER+="title: $TITLE\n"
  FRONTMATTER+="date: $(date +%F)\n"
  FRONTMATTER+='tags:\n'
  FRONTMATTER+='layout: post\n'
  FRONTMATTER+='---\n\n'

  echo -e $FRONTMATTER > "$FILENAME"
  edit_file "$FILENAME"
}

edit_file() {
  FILENAME="$1"
  [ -z "$EDITOR" ] && EDITOR='vi'
  $EDITOR "$FILENAME"
}

path_not_found() {
  1>&2 echo "Error! No valid blog location found. Create one of the following \
    directories:"

  for i in "${possiblePaths[@]}"; do
    [ -n "$i" ] && 1>&2 echo "$i"
  done
  exit 1
}

TITLE=$1

if [ -z "$TITLE" ]; then
  1>&2 echo 'Please provide blog post title as first argument.'
  exit 1
fi

possiblePaths=(
  "$BLOG"
  "$NOTES"
  "$HOME/Documents"
  "$HOME/documents"
  "$HOME/Desktop"
)

for i in "${possiblePaths[@]}"; do
  if [ -d "$i" ]; then
    create_file "$i" "$TITLE"
    exit 0
  fi
done

path_not_found
