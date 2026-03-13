#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 2 ]; then
  echo "Usage: scripts/compare-outputs.sh <file_a> <file_b>"
  exit 1
fi

FILE_A="$1"
FILE_B="$2"

if [ ! -f "$FILE_A" ]; then
  echo "First file not found: $FILE_A"
  exit 1
fi

if [ ! -f "$FILE_B" ]; then
  echo "Second file not found: $FILE_B"
  exit 1
fi

echo "=== FILE A: $FILE_A ==="
echo
cat "$FILE_A"
echo
echo "=== FILE B: $FILE_B ==="
echo
cat "$FILE_B"
echo
echo "=== DIFF ==="
diff -u "$FILE_A" "$FILE_B" || true
