# Model Registry

## Fields
- model name
- source
- size
- quant
- runtime
- status
- notes

## Entries
- model name: qwen2.5:14b
  source: Ollama
  size: 14b
  quant: unknown
  runtime: local
  status: candidate
  notes: passed one-line grammar sanity check cleanly; no reasoning leakage; good candidate for proofreading baseline
- model name: qwen2.5:14b
  source: Ollama
  size: 14b
  quant: unknown
  runtime: local
  status: current baseline
  notes: current best lore-safe proofreading baseline with prompts/lore-safe-proofread-003.md; clean output, no reasoning leakage, good minimal-edit behavior, somewhat slow
