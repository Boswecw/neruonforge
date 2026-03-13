# Drift Boundary

## Current Baseline
- model: qwen2.5:14b
- prompt: prompts/lore-safe-proofread-003.md

## Observed Repeatability
Repeated runs remain compliant in output format, protected term preservation, and core proofreading behavior.

## Observed Drift
Small phrase-level variation can still occur between runs.

### Confirmed Example
- "her silence said enough"
- "her silence spoke enough"

## Current Boundary Judgment
This level of drift is acceptable for manual proofreading assistance because:
- meaning remains effectively unchanged
- canon terms remain stable
- output format remains stable
- reasoning leakage is absent

## Operational Rule
Treat the current baseline as suitable for assisted proofreading, but continue manual review for final acceptance.
