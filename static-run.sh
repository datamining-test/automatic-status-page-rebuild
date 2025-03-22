#!/bin/bash

if [[ -z "$INGEST_PATH" ]]; then
    echo "Error: INGEST_PATH environment variable is not set" >&2
    exit 1
fi

startTime=$(date +%s%3N)

commitMessage=$(git log -1 --pretty=%s)

url="${INGEST_PATH}?commit=${commitMessage}&startTime=${startTime}"

cat ./report.sh | bash -s -- -i -b -6 -s "$url"
