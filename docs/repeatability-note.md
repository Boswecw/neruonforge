# Repeatability Note

## Observation
The reusable script works correctly and removes manual command assembly errors.

## Model Behavior
qwen2.5:14b remains clean and compliant for the current lore-safe proofreading baseline, but repeated runs can still produce small wording differences.

## Current Interpretation
- output format is stable
- reasoning leakage is absent
- protected terms are stable
- proofreading quality is strong
- minimal-edit behavior is good but not perfectly repeatable at phrase level

## Practical Conclusion
This baseline is usable for manual proofreading workflows, but outputs should still be reviewed rather than treated as perfectly deterministic.
