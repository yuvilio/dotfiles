#!/usr/bin/env bash
#$1 is the new prefix to add

for file in  $(ls *) ; do
  mv $file $1$file
done
