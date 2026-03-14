# Run Registry

## Fields
- run id
- date
- model
- prompt file
- input file
- output file
- task
- notes

## Entries
- run id: run-2026-03-13-001
  date: 2026-03-13
  model: deepseek-r1:7b
  prompt file: prompts/proofread-basic-001.md
  input file: inputs/test-proofread-001.md
  output file: outputs/deepseek-r1-7b-proofread-001.md
  task: baseline proofreading test
  notes: produced visible reasoning and violated return-only-text rule; made some correct edits but also introduced a meaning shift
- run id: run-2026-03-13-002
  date: 2026-03-13
  model: deepseek-r1:7b
  prompt file: prompts/lore-safe-proofread-001.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/deepseek-r1-7b-lore-safe-001.md
  task: lore-safe proofreading baseline
  notes: failed hard; exposed reasoning, added commentary, violated return-only-text rule, altered imagery and meaning
- run id: run-2026-03-13-003
  date: 2026-03-13
  model: deepseek-r1:7b
  prompt file: prompts/lore-safe-proofread-002.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/deepseek-r1-7b-lore-safe-002.md
  task: lore-safe proofreading prompt revision test
  notes: still failed; reasoning leakage remained, commentary remained, output format failed, and proofreading quality remained unreliable
- run id: run-2026-03-13-004
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-002.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-001.md
  task: lore-safe proofreading comparison baseline
  notes: strong improvement over deepseek-r1:7b; no reasoning leakage or commentary; output format passed; still made some non-minimal wording changes; speed somewhat slow
- run id: run-2026-03-13-005
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-002.md
  task: lore-safe proofreading minimal-edit revision test
  notes: best result so far; clean output, no reasoning leakage, protected terms preserved, unnecessary rewrites reduced; still changed "sat badly in him" to "sat badly with him"
- run id: run-2026-03-13-006
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-003.md
  task: lore-safe proofreading repeatability check via script
  notes: script worked; output remained clean and compliant; slight wording drift remained between repeated runs, so behavior is usable but not perfectly deterministic
- run id: run-2026-03-13-007
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-004.md
  task: lore-safe proofreading review-workflow stability check
  notes: review helper script worked correctly; output matched prior run exactly; no diff against outputs/qwen2.5-14b-lore-safe-003.md

- run id: run-2026-03-13-008
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-004.md
  task: helper script logging test
  notes: test entry created by scripts/log-run.sh

- run id: run-2026-03-13-009
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-005.md
  task: wrapper script end-to-end test
  notes: proofread and log completed through wrapper script

- run id: run-2026-03-13-011
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-006.md
  task: wrapper auto-date test
  notes: date omitted intentionally; wrapper should fill with system date

- run id: run-2026-03-13-012
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-007.md
  task: wrapper auto-run-id test
  notes: run id and date omitted intentionally; wrapper should fill both

- run id: run-2026-03-13-013
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-test-001-run-2026-03-13-013.md
  task: wrapper auto-output test
  notes: run id, date, and output omitted intentionally; wrapper should fill all three

- run id: run-2026-03-13-014
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-test-001-run-2026-03-13-014.md
  task: proofread
  notes: live run verification

- run id: run-2026-03-13-015
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-test-001-run-2026-03-13-015.md
  task: proofread
  notes: post-hardening live run

- run id: run-2026-03-13-016
  date: 2026-03-13
  model: gemma3:4b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/gemma3-4b-lore-safe-test-001-run-2026-03-13-016.md
  task: lore-safe proofreading challenger test
  notes: stayed inside output contract and preserved terms and tone, but failed challenger review due to core grammar errors


- run id: run-2026-03-13-017
  date: 2026-03-13
  model: qwen2.5:7b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-7b-lore-safe-test-001-run-2026-03-13-017.md
  task: lore-safe proofreading challenger test
  notes: qwen2.5:7b challenger run against current qwen2.5:14b baseline

- run id: run-2026-03-13-018
  date: 2026-03-13
  model: gemma3:12b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/gemma3-12b-lore-safe-test-001-run-2026-03-13-018.md
  task: lore-safe proofreading challenger test
  notes: gemma3:12b challenger run against current qwen2.5:14b baseline

- run id: run-2026-03-13-019
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-004.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/qwen2.5-14b-lore-safe-test-001-run-2026-03-13-019.md
  task: lore-safe proofreading prompt challenger test
  notes: qwen2.5:14b test of prompt 004 against current prompt 003 baseline

- run id: run-2026-03-13-020
  date: 2026-03-13
  model: llama3.1:8b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/run-2026-03-13-020-lore-safe-test-001-llama3.1-8b.md
  task: lore-safe-proofreading
  notes: challenger run for llama3.1:8b against current qwen2.5:14b baseline

- run id: run-2026-03-13-021
  date: 2026-03-13
  model: mistral:7b-instruct
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/run-2026-03-13-021-lore-safe-test-001-mistral-7b-instruct.md
  task: lore-safe-proofreading
  notes: challenger run for mistral:7b-instruct against current qwen2.5:14b baseline

- run id: run-2026-03-13-022
  date: 2026-03-13
  model: olmo2:13b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/run-2026-03-13-022-lore-safe-test-001-olmo2-13b.md
  task: lore-safe-proofreading
  notes: challenger run for olmo2:13b against current qwen2.5:14b baseline

- run id: run-2026-03-13-023
  date: 2026-03-13
  model: cogito:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/run-2026-03-13-023-lore-safe-test-001-cogito-14b.md
  task: lore-safe-proofreading
  notes: challenger run for cogito:14b against current qwen2.5:14b baseline

- run id: run-2026-03-13-024
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-001.md
  output file: outputs/run-2026-03-13-024-lore-safe-test-001-phi4-14b.md
  task: lore-safe-proofreading
  notes: challenger run for phi4:14b against current qwen2.5:14b baseline

- run id: run-2026-03-13-025
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-002.md
  output file: outputs/run-2026-03-13-025-lore-safe-test-002-qwen2.5-14b.md
  task: lore-safe-proofreading
  notes: baseline suite expansion test 002 with locked qwen baseline

- run id: run-2026-03-13-026
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-002.md
  output file: outputs/run-2026-03-13-026-lore-safe-test-002-phi4-14b.md
  task: lore-safe-proofreading
  notes: challenger suite expansion test 002 with phi4 contender

- run id: run-2026-03-13-027
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-003.md
  output file: outputs/run-2026-03-13-027-lore-safe-test-003-qwen2.5-14b.md
  task: lore-safe-proofreading
  notes: baseline suite expansion test 003 with locked qwen baseline

- run id: run-2026-03-13-028
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-003.md
  output file: outputs/run-2026-03-13-028-lore-safe-test-003-phi4-14b.md
  task: lore-safe-proofreading
  notes: challenger suite expansion test 003 with phi4 contender

- run id: run-2026-03-13-029
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-004.md
  output file: outputs/run-2026-03-13-029-lore-safe-test-004-qwen2.5-14b.md
  task: lore-safe-proofreading
  notes: baseline suite expansion test 004 with locked qwen baseline

- run id: run-2026-03-13-030
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-004.md
  output file: outputs/run-2026-03-13-030-lore-safe-test-004-phi4-14b.md
  task: lore-safe-proofreading
  notes: challenger suite expansion test 004 with phi4 contender

- run id: run-2026-03-13-031
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-005.md
  output file: outputs/run-2026-03-13-031-lore-safe-test-005-qwen2.5-14b.md
  task: lore-safe-proofreading
  notes: baseline suite expansion test 005 with locked qwen baseline

- run id: run-2026-03-13-032
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-005.md
  output file: outputs/run-2026-03-13-032-lore-safe-test-005-phi4-14b.md
  task: lore-safe-proofreading
  notes: challenger suite expansion test 005 with phi4 contender

- run id: run-2026-03-13-033
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-006.md
  output file: outputs/run-2026-03-13-033-lore-safe-test-006-qwen2.5-14b.md
  task: lore-safe-proofreading
  notes: baseline suite expansion test 006 with locked qwen baseline

- run id: run-2026-03-13-034
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/lore-safe-proofread-003.md
  input file: inputs/lore-safe-test-006.md
  output file: outputs/run-2026-03-13-034-lore-safe-test-006-phi4-14b.md
  task: lore-safe-proofreading
  notes: challenger suite expansion test 006 with phi4 contender

- run id: run-2026-03-13-035
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/general-grammar-cleanup-001.md
  input file: inputs/general-grammar-test-001.md
  output file: outputs/qwen2.5-14b-general-grammar-test-001.md
  task: general-grammar-cleanup
  notes: anchor run for general grammar lane

- run id: run-2026-03-13-036
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/general-grammar-cleanup-001.md
  input file: inputs/general-grammar-test-001.md
  output file: outputs/phi4-14b-general-grammar-test-001.md
  task: general-grammar-cleanup
  notes: anchor run for general grammar lane

- run id: run-2026-03-13-037
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/general-grammar-cleanup-001.md
  input file: inputs/general-grammar-test-002.md
  output file: outputs/qwen2.5-14b-general-grammar-test-002.md
  task: general-grammar-cleanup
  notes: test 002 for general grammar lane

- run id: run-2026-03-13-038
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/general-grammar-cleanup-001.md
  input file: inputs/general-grammar-test-002.md
  output file: outputs/phi4-14b-general-grammar-test-002.md
  task: general-grammar-cleanup
  notes: test 002 for general grammar lane

- run id: run-2026-03-13-039
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/general-grammar-cleanup-001.md
  input file: inputs/general-grammar-test-003.md
  output file: outputs/qwen2.5-14b-general-grammar-test-003.md
  task: general-grammar-cleanup
  notes: test 003 for general grammar lane

- run id: run-2026-03-13-040
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/general-grammar-cleanup-001.md
  input file: inputs/general-grammar-test-003.md
  output file: outputs/phi4-14b-general-grammar-test-003.md
  task: general-grammar-cleanup
  notes: test 003 for general grammar lane

- run id: run-2026-03-13-041
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/general-grammar-cleanup-001.md
  input file: inputs/general-grammar-test-004.md
  output file: outputs/qwen2.5-14b-general-grammar-test-004.md
  task: general-grammar-cleanup
  notes: test 004 for general grammar lane

- run id: run-2026-03-13-042
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/general-grammar-cleanup-001.md
  input file: inputs/general-grammar-test-004.md
  output file: outputs/phi4-14b-general-grammar-test-004.md
  task: general-grammar-cleanup
  notes: test 004 for general grammar lane

- run id: run-2026-03-13-043
  date: 2026-03-13
  model: qwen2.5:14b
  prompt file: prompts/general-grammar-cleanup-001.md
  input file: inputs/general-grammar-test-005.md
  output file: outputs/qwen2.5-14b-general-grammar-test-005.md
  task: general-grammar-cleanup
  notes: test 005 for general grammar lane

- run id: run-2026-03-13-044
  date: 2026-03-13
  model: phi4:14b
  prompt file: prompts/general-grammar-cleanup-001.md
  input file: inputs/general-grammar-test-005.md
  output file: outputs/phi4-14b-general-grammar-test-005.md
  task: general-grammar-cleanup
  notes: test 005 for general grammar lane
