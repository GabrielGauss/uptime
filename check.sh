#!/usr/bin/env bash
# Checks every target in targets.txt. Prints one line per target and writes
# the failures to failures.md. Exit 0 always; the workflow decides on issues.
set -uo pipefail
: > failures.md
while IFS='|' read -r name url expected; do
  name="$(echo "$name" | xargs)"; url="$(echo "$url" | xargs)"; expected="$(echo "$expected" | xargs)"
  [[ -z "$name" || "$name" == \#* ]] && continue
  got="000"
  for attempt in 1 2 3; do  # retry to ride out a single dropped request
    got="$(curl -s -o /dev/null -w '%{http_code}' --max-time 15 "$url" || true)"
    [[ "$got" == "$expected" ]] && break
    sleep 10
  done
  if [[ "$got" == "$expected" ]]; then
    echo "OK   $name ($got) $url"
  else
    echo "DOWN $name (got $got, want $expected) $url"
    echo "- **$name**: got \`$got\`, expected \`$expected\` — $url" >> failures.md
  fi
done < targets.txt
