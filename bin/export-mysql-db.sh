#!/usr/bin/env sh

#ex: export-db.sh DBNAME 

echo "exporting database $1"
dbfile=$1-$(date '+%Y-%m-%d-%H-%M').sql.gz
mysqldump --add-drop-table $1 | gzip -c > $dbfile
echo "database exported to $dbfile"
