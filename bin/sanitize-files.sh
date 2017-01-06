#!/usr/bin/env bash
#$1 is the new extension

# sanitize file (remove special characters that make listing/copying/other processing.. files hard). switch with '-'
# source: https://odoepner.wordpress.com/2011/10/13/bash-script-to-recursively-sanitize-folder-and-file-names/

sanitize() {
  shopt -s extglob;

  filename=$(basename "$1")
  directory=$(dirname "$1")

  filename_clean="${filename//+([^[:alnum:]_-\.])/-}"

  if (test "$filename" != "$filename_clean")
  then
    mv -v --backup=numbered "$1" "$directory/$filename_clean"
  fi
}

export -f sanitize
find $1 -depth -exec bash -c 'sanitize "$0"' {} \;
