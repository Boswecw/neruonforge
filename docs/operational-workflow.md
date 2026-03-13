# Neuronforge Operational Workflow

## Purpose

This document defines the operator workflow for running proofreading experiments in a controlled, repeatable, manual-first way.

The workflow is designed to support:

- one change at a time
- explicit verification after each run
- clean run logging
- repeatable command usage
- low-friction preflight checks before execution

---

## Core scripts

### `scripts/run-proofread.sh`

Runs a proofreading job from:

- model
- prompt file
- input file
- output file

It writes the model output to the requested output path.

### `scripts/log-run.sh`

Appends a formatted run record to:

- `registry/runs.md`

### `scripts/next-run-id.sh`

Scans `registry/runs.md` for the current date and prints the next available run id in this format:

- `run-YYYY-MM-DD-NNN`

### `scripts/run-and-log-proofread.sh`

Primary operator wrapper.

This script can:

- run proofreading
- write output
- log the run
- auto-fill date
- auto-fill run id
- auto-fill output filename
- perform dry-run preflight without executing or logging

---

## Standard verification after runs

After a live run, verify:

```bash
wc -l <output-file>
tail -n 14 registry/runs.md
```
