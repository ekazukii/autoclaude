#!/bin/bash
# Appends the full assistant output to memory/devlog on every Stop event.

INPUT=$(cat)
RESPONSE=$(echo "$INPUT" | jq -r '.stop_response // empty')

if [[ -z "$RESPONSE" ]]; then
  exit 0
fi

mkdir -p memory

echo "=== $(date '+%Y-%m-%d %H:%M:%S') ===" >> memory/devlog
echo "$RESPONSE" >> memory/devlog
echo "" >> memory/devlog

exit 0
