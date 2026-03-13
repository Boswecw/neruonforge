#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -lt 4 ] || [ "$#" -gt 5 ]; then
  echo "Usage: scripts/review-proofread.sh <model> <prompt_file> <input_file> <output_file> [prior_output_file]"
  exit 1
fi

MODEL="$1"
PROMPT_FILE="$2"
INPUT_FILE="$3"
OUTPUT_FILE="$4"
PRIOR_OUTPUT="${5:-}"

if [ ! -f "$PROMPT_FILE" ]; then
  echo "Prompt file not found: $PROMPT_FILE"
  exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
  echo "Input file not found: $INPUT_FILE"
  exit 1
fi

mkdir -p "$(dirname "$OUTPUT_FILE")"

(
  cat "$PROMPT_FILE"
  printf '\n\nPASSAGE:\n\n'
  cat "$INPUT_FILE"
) | ollama run "$MODEL" > "$OUTPUT_FILE"

echo
echo "Saved output to: $OUTPUT_FILE"
echo
echo "=== NEW OUTPUT ==="
cat "$OUTPUT_FILE"
echo

if [ -n "$PRIOR_OUTPUT" ]; then
  if [ ! -f "$PRIOR_OUTPUT" ]; then
    echo "Prior output file not found: $PRIOR_OUTPUT"
    exit 1
  fi

  echo
  echo "=== DIFF VS PRIOR OUTPUT ==="
  diff -u "$PRIOR_OUTPUT" "$OUTPUT_FILE" || true
fi
