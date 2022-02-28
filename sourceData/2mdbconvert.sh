#!/bin/bash

TABLES=$(mdb-tables -1 $1)

MUSER="root"
MPASS="0911"
MDB="$2"

MYSQL=$(which mysql)
TROUBLES=("Artist Information" "Link Art Terms" "Link Cultures" "Link Monographs" "Link Periodicals" "Unique Art Terms" "Unique Cultures" "Unique monographs")

for t in $TROUBLES
do
    sudo $MYSQL $MDB -e "DROP TABLE IF EXISTS `$t`"
done

mdb-schema $1 mysql | sudo $MYSQL  $MDB


for t in $TROUBLES
do
    mdb-export -D '%Y-%m-%d %H:%M:%S' -I mysql $1 "$t" | sudo $MYSQL $MDB
done
