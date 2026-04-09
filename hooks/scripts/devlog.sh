#!/bin/bash
# Appends the last assistant message to memory/devlog on every Stop event.

INPUT=$(cat)
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path // empty')

if [[ -z "$TRANSCRIPT" || ! -f "$TRANSCRIPT" ]]; then
  exit 0
fi

RESPONSE=$(jq -rs '
  map(select(.type == "assistant"))
  | last
  | .message.content
  | map(select(.type == "text") | .text)
  | join("\n")
' "$TRANSCRIPT")

if [[ -z "$RESPONSE" ]]; then
  exit 0
fi

mkdir -p memory

{
  echo "=== $(date '+%Y-%m-%d %H:%M:%S') ==="
  echo "$RESPONSE"
  echo
} >> memory/devlog

exit 0
