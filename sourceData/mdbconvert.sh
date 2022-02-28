#!/bin/bash

TABLES=$(mdb-tables -1 $1)

MUSER="root"
MPASS="0911"
MDB="$2"

MYSQL=$(which mysql)

for t in $TABLES
do
    sudo $MYSQL $MDB -e "DROP TABLE IF EXISTS `$t`"
done

mdb-schema $1 mysql | sudo $MYSQL  $MDB

for t in $TABLES
do
    mdb-export -D '%Y-%m-%d %H:%M:%S' -I mysql $1 "$t" | sudo $MYSQL $MDB
done
