#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 4 ]; then
  echo "Usage: scripts/run-proofread.sh <model> <prompt_file> <input_file> <output_file>"
  exit 1
fi

MODEL="$1"
PROMPT_FILE="$2"
INPUT_FILE="$3"
OUTPUT_FILE="$4"

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

echo "Saved output to: $OUTPUT_FILE"
