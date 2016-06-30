#!/bin/bash

env

if [[ -n "${BOOKKEEPER_ZOOKEEPER_CONNECT}" ]]; then
  sed -i "s/zkServers=localhost:2181/zkServers=${BOOKKEEPER_ZOOKEEPER_CONNECT}/" /opt/bookkeeper/conf/bk_server.conf
fi

# Interferes with Onyx ZK cleanup
#if [[ -n "${BOOKKEEPER_ZK_LEDGER_ROOT_PATH}" ]]; then
#  echo "zkLedgersRootPath=${BOOKKEEPER_ZK_LEDGER_ROOT_PATH}" >> /opt/bookkeeper/conf/bk_server.conf
#fi

for setting in indexDirectories journalDirectory ledgerDirectories; do
  dirValue=$(grep "^$setting" conf/bk_server.conf | sed -e 's/.*=//')
  if [[ -z "${dirValue}" ]]; then
    echo "$setting is missing in the configuration file"
    exit 1
  fi
done

/opt/bookkeeper/bin/bookkeeper-daemon.sh start bookie