#!/usr/bin/env bash
set -euo pipefail

DRY_RUN=0

if [ "${1:-}" = "--dry-run" ]; then
  DRY_RUN=1
  shift
fi

if [ "$#" -ne 5 ] && [ "$#" -ne 6 ] && [ "$#" -ne 7 ] && [ "$#" -ne 8 ]; then
  echo "Usage:"
  echo "  $0 [--dry-run] [RUN_ID] [DATE] MODEL PROMPT_FILE INPUT_FILE [OUTPUT_FILE] TASK NOTES"
  echo
  echo "Accepted forms:"
  echo "  8 args: RUN_ID DATE MODEL PROMPT_FILE INPUT_FILE OUTPUT_FILE TASK NOTES"
  echo "  7 args: RUN_ID MODEL PROMPT_FILE INPUT_FILE OUTPUT_FILE TASK NOTES"
  echo "  6 args: MODEL PROMPT_FILE INPUT_FILE OUTPUT_FILE TASK NOTES"
  echo "  5 args: MODEL PROMPT_FILE INPUT_FILE TASK NOTES"
  exit 1
fi

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

if [ ! -x scripts/run-proofread.sh ]; then
  echo "Error: scripts/run-proofread.sh is missing or not executable"
  exit 1
fi

if [ ! -x scripts/log-run.sh ]; then
  echo "Error: scripts/log-run.sh is missing or not executable"
  exit 1
fi

if [ ! -x scripts/next-run-id.sh ]; then
  echo "Error: scripts/next-run-id.sh is missing or not executable"
  exit 1
fi

if [ "$#" -eq 8 ]; then
  RUN_ID="$1"
  DATE_STR="$2"
  MODEL="$3"
  PROMPT_FILE="$4"
  INPUT_FILE="$5"
  OUTPUT_FILE="$6"
  TASK="$7"
  NOTES="$8"
elif [ "$#" -eq 7 ]; then
  RUN_ID="$1"
  DATE_STR="$(date +%F)"
  MODEL="$2"
  PROMPT_FILE="$3"
  INPUT_FILE="$4"
  OUTPUT_FILE="$5"
  TASK="$6"
  NOTES="$7"
elif [ "$#" -eq 6 ]; then
  RUN_ID="$(scripts/next-run-id.sh)"
  DATE_STR="$(date +%F)"
  MODEL="$1"
  PROMPT_FILE="$2"
  INPUT_FILE="$3"
  OUTPUT_FILE="$4"
  TASK="$5"
  NOTES="$6"
else
  RUN_ID="$(scripts/next-run-id.sh)"
  DATE_STR="$(date +%F)"
  MODEL="$1"
  PROMPT_FILE="$2"
  INPUT_FILE="$3"
  TASK="$4"
  NOTES="$5"

  MODEL_SLUG="$(printf '%s' "$MODEL" | tr ':/' '--')"
  INPUT_BASE="$(basename "$INPUT_FILE")"
  INPUT_BASE="${INPUT_BASE%.*}"
  OUTPUT_FILE="outputs/${MODEL_SLUG}-${INPUT_BASE}-${RUN_ID}.md"
fi

if [ ! -f "$PROMPT_FILE" ]; then
  echo "Error: prompt file not found: $PROMPT_FILE"
  exit 1
fi

if [ ! -f "$INPUT_FILE" ]; then
  echo "Error: input file not found: $INPUT_FILE"
  exit 1
fi

if [ "$DRY_RUN" -eq 1 ]; then
  echo "Dry run only. No proofread executed. No log written."
  echo "  run id:      $RUN_ID"
  echo "  date:        $DATE_STR"
  echo "  model:       $MODEL"
  echo "  prompt file: $PROMPT_FILE"
  echo "  input file:  $INPUT_FILE"
  echo "  output file: $OUTPUT_FILE"
  echo "  task:        $TASK"
  echo "  notes:       $NOTES"
  exit 0
fi

scripts/run-proofread.sh \
  "$MODEL" \
  "$PROMPT_FILE" \
  "$INPUT_FILE" \
  "$OUTPUT_FILE"

scripts/log-run.sh \
  "$RUN_ID" \
  "$DATE_STR" \
  "$MODEL" \
  "$PROMPT_FILE" \
  "$INPUT_FILE" \
  "$OUTPUT_FILE" \
  "$TASK" \
  "$NOTES"

echo
echo "Run complete and logged:"
echo "  run id: $RUN_ID"
echo "  date:   $DATE_STR"
echo "  output: $OUTPUT_FILE"
