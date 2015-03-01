#!/usr/bin/env bash

#ex:  Have the database name be the first part of the file (delimited by dash '-').
#import-db.sh ~/Downloads/DBNAME-2015-02-20-0154.sql.gz

bn=$(basename $1)
dir=$(dirname $1)
arr=(${bn//-/ })
exts=(${bn//\./ })
db=${arr[0]}
echo "importing database: $db"

mysql -e "drop database $db; create database $db;"

if [ ${exts[ ${#exts[@]} - 1 ]} == "gz" ]; then
  zcat $1 | mysql -D $db
else
  cat $1 | mysql -D $db
fi
