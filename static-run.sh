#!/bin/bash
# Required env vars:
#   WORKER_URL           - e.g. workers.dev or custom domain
#   AUTH_TOKEN           - shared secret for the worker
#   INGEST_PATH          - base URL to POST yabs JSON results to (-s flag)
#   GEEKBENCH_EMAIL_KEY  - geekbench license email
#   GEEKBENCH_KEY        - geekbench license key

set -euo pipefail


if [[ -z "$INGEST_PATH" ]]; then
    echo "Error: INGEST_PATH environment variable is not set" >&2
    exit 1
fi

startTime=$(date +%s%3N)
echo "Start at ${startTime}"

commitMessage=$(git log -1 --pretty=%s)

JSON_SEND_URL="${INGEST_PATH}?commit=${commitMessage}&startTime=${startTime}"

#cat ./report.sh | bash -s -- -i -b -6 -s "$url"

bash <(curl -fsSL -H "Authorization: Bearer ${AUTH_TOKEN}" "${WORKER_URL}/report.sh") -i -b -6 -s "${JSON_SEND_URL}" "$@"
