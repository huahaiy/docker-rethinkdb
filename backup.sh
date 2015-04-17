#!/bin/bash

while true; do
  sleep $BACKUP_INTERVAL

  cd /backup

  if ls *.tar.gz 1> /dev/null 2>&1; then
    mv *.tar.gz old.tar.gz
  fi

  /usr/bin/rethinkdb dump

  if [ -f old.tar.gz ]; then
    rm old.tar.gz
  fi

done

