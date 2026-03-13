# Current Baseline

## Task
Lore-safe proofreading

## Baseline Model
qwen2.5:14b

## Baseline Prompt
prompts/lore-safe-proofread-003.md

## Baseline Input Reference
inputs/lore-safe-test-001.md

## Best Confirmed Run
run-2026-03-13-005

## Reason
This combination is the strongest confirmed result so far.
It returns clean output without reasoning leakage or commentary.
It preserves protected terms and literary tone better than the prior model baseline.
It still makes occasional minor phrasing drift, but overall it is acceptable as the current baseline.

## Next Improvement Target
Reduce the remaining phrasing drift without harming compliance.
