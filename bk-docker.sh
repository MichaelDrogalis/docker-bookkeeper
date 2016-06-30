#!/bin/bash

BK_CFG_FILE="/opt/bookkeeper/conf/bk_server.conf"

# Download the config file, if given a URL
if [ ! -z "$BK_CFG_URL" ]; then
  echo "[zk] Downloading zk config file from ${BK_CFG_URL}"
  curl --location --silent --insecure --output ${BK_CFG_FILE} ${BK_CFG_URL}
  if [ $? -ne 0 ]; then
    echo "[zk] Failed to download ${BK_CFG_URL} exiting."
    exit 1
  fi
fi

if [[ -n "${BOOKKEEPER_ZOOKEEPER_CONNECT}" ]]; then
  sed -i "s/zkServers=localhost:2181/zkServers=${BOOKKEEPER_ZOOKEEPER_CONNECT}/" "${BK_CFG_FILE}"
fi

# Interferes with Onyx ZK cleanup
#if [[ -n "${BOOKKEEPER_ZK_LEDGER_ROOT_PATH}" ]]; then
#  echo "zkLedgersRootPath=${BOOKKEEPER_ZK_LEDGER_ROOT_PATH}" >> "${BK_CFG_FILE}"
#fi

for setting in indexDirectories journalDirectory ledgerDirectories; do
  dirValue=$(grep "^$setting" "${BK_CFG_FILE}" | sed -e 's/.*=//')
  if [[ -z "${dirValue}" ]]; then
    echo "$setting is missing in the configuration file"
    exit 1
  fi
done

env

cat "${BK_CFG_FILE}"

exec $@