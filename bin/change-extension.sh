#!/usr/bin/env bash
#$1 is the new extension

for file in  $(ls *) ; do
  arr=(${file//\./ })
  mv $file ${arr[0]}.$1
done
