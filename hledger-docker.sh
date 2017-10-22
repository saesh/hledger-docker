#!/usr/bin/env bash

LOCAL_JOURNAL_FOLDER=/path/to/local/journals
JOURNAL_FILE=$1

docker run --rm -e LEDGER_FILE=/journals/${JOURNAL_FILE} -v "${LOCAL_JOURNAL_FOLDER}:/journals" -p 5000:5000 hledger-docker ${@:2}
