# Neuronforge

Neuronforge is a local-first experiment workspace for controlled proofreading evaluation.

The current project phase is centered on lore-safe proofreading experiments with explicit run logging, manual validation, baseline tracking, and controlled operational discipline.

It is not currently positioned as a broad general-purpose model lab.

---

## Current focus

The active focus is:

- lore-safe proofreading
- prompt-controlled local model runs
- repeatable output capture
- structured run logging
- manual review against explicit acceptance criteria
- controlled baseline comparison

Current documented baseline:

- model: `qwen2.5:14b`
- prompt: `prompts/lore-safe-proofread-003.md`
- input reference: `inputs/lore-safe-test-001.md`

Current best confirmed quality anchor:

- `run-2026-03-13-005`

Latest successful wrapper-driven operational verification runs:

- `run-2026-03-13-014`
- `run-2026-03-13-015`

---

## Repository layout

- `docs/`  
  Control documents for workflow, baseline status, review discipline, drift boundaries, repeatability, and scope.

- `inputs/`  
  Source texts used for proofreading runs.

- `prompts/`  
  Prompt files used to drive controlled model behavior.

- `outputs/`  
  Saved model outputs from manual or wrapper-driven runs.

- `registry/`  
  Structured registries for runs, prompts, models, protected terms, and style preferences.

- `evals/`  
  Per-run review notes and quality assessments.

- `notes/`  
  Supporting working notes and revision logs.

- `scripts/`  
  Operator utilities for running, logging, reviewing, and comparing proofreading outputs.

---

## Primary documents

Start here for the current control surface:

- `docs/workflow.md`
- `docs/operational-workflow.md`
- `docs/current-baseline.md`
- `docs/manual-validator.md`
- `docs/review-checklist.md`
- `docs/change-control.md`
- `docs/drift-boundary.md`
- `docs/repeatability-note.md`
- `docs/experiment-scope.md`

---

## Primary scripts

Current core execution path:

- `scripts/run-proofread.sh`
- `scripts/log-run.sh`
- `scripts/next-run-id.sh`
- `scripts/run-and-log-proofread.sh`

Supporting utilities:

- `scripts/review-proofread.sh`
- `scripts/compare-outputs.sh`

---

## Current operating posture

Neuronforge is presently being run in a manual-first, verification-heavy mode.

The current posture emphasizes:

- reproducible runs
- explicit run records
- separation of quality validation from workflow verification
- careful baseline promotion
- documented interpretation of failures

Operational success does not by itself replace the current quality baseline.

A later run only becomes the new baseline when it is explicitly reviewed and accepted as a better result.

---

## Boundary note

A real Ollama runtime memory failure has already been observed during testing.

That failure is treated as a runtime resource boundary, not as evidence that the wrapper workflow is incorrect.

This distinction matters to the current experiment design.

---

## Status

The repository now has a coherent documentation spine for the current proofreading baseline phase.

The next work should continue from one of these paths:

- baseline improvement
- further prompt refinement
- additional model comparison against the current quality anchor
- tighter operational scripting where needed
