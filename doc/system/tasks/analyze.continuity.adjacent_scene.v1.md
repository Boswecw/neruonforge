# Task Contract: analyze.continuity.adjacent_scene.v1

Date: 2026-03-14

## Identity

- **task_id:** `analyze.continuity.adjacent_scene.v1`
- **contract_version:** `1.0`
- **family:** `analysis`
- **lane_id:** `continuity-progression-reasoning`
- **scope:** `adjacent_scene`
- **trust_posture:** `candidate_only`
- **route_class:** `HIGH_QUALITY_LOCAL`
- **strictness:** `STRICT_STRUCTURED`
- **fallback_policy:** `fail_closed`

---

## Purpose

Accept a bounded two-scene packet and return a strict structured candidate artifact containing continuity and progression findings for reviewer consideration.

This is the first live task contract for the `continuity-progression-reasoning` lane.

---

## Non-goals for v1

This contract does not support:

- scene-window or chapter-window execution
- automatic canonical writes
- silent prose fallback on schema failure
- promotion or lifecycle management

---

## Request shape

```json
{
  "task_id": "analyze.continuity.adjacent_scene.v1",
  "scope_label": "adjacent_scene",
  "scene_packet_id": "<string>",
  "scene_a_id": "<string>",
  "scene_b_id": "<string>",
  "scene_a_text": "<string>",
  "scene_b_text": "<string>",
  "packet_metadata": {}
}
```

### Required request fields

| Field | Type | Description |
|-------|------|-------------|
| `task_id` | string | Must be `analyze.continuity.adjacent_scene.v1` |
| `scene_a_id` | string | Identifier for the first (earlier) scene |
| `scene_b_id` | string | Identifier for the second (later) scene |
| `scene_a_text` | string | Full text of scene A |
| `scene_b_text` | string | Full text of scene B |

### Optional request fields

| Field | Type | Description |
|-------|------|-------------|
| `scope_label` | string | Defaults to `adjacent_scene` |
| `scene_packet_id` | string | Identifier for this analysis packet |
| `packet_metadata` | object | Operator notes, chapter context, etc. |

---

## Candidate artifact envelope shape

On success, the executor returns a candidate artifact envelope:

```json
{
  "task_id": "analyze.continuity.adjacent_scene.v1",
  "contract_version": "1.0",
  "route_class": "HIGH_QUALITY_LOCAL",
  "model_id": "<model-name>",
  "run_id": "<run-id>",
  "timestamp": "<ISO 8601 UTC>",
  "scene_packet_id": "<string>",
  "scope_label": "adjacent_scene",
  "envelope_status": "valid_candidate",
  "candidate_findings": [...],
  "overall_run_note": "<string>",
  "validation_result": {
    "validation_result": "valid",
    "schema_version_checked": "1.0",
    "validated_at": "<ISO 8601 UTC>",
    "findings_count": 0
  },
  "run_metadata": {
    "prompt_file": "prompts/continuity-adjacent-scene-v1.md",
    "request_file": "<path>",
    "raw_output_file": "<path>"
  }
}
```

### Envelope status values

| Value | Meaning |
|-------|---------|
| `valid_candidate` | Schema passed; findings are valid candidates for review |
| `fail_closed` | Schema failed or model failed; no findings promoted |

---

## Fail-closed envelope shape

On any failure (model failure or schema validation failure), the executor returns a structured failure envelope:

```json
{
  "task_id": "analyze.continuity.adjacent_scene.v1",
  "contract_version": "1.0",
  "route_class": "HIGH_QUALITY_LOCAL",
  "model_id": "<model-name>",
  "run_id": "<run-id>",
  "timestamp": "<ISO 8601 UTC>",
  "scene_packet_id": "<string>",
  "scope_label": "adjacent_scene",
  "envelope_status": "fail_closed",
  "failure_reason": "<string>",
  "candidate_findings": [],
  "validation_result": null,
  "run_metadata": {
    "prompt_file": "prompts/continuity-adjacent-scene-v1.md",
    "request_file": "<path>",
    "raw_output_file": "<path or null>"
  }
}
```

Zero findings are always returned on failure. No silent coercion.

---

## Schema contract for model output

The model must return a top-level JSON object matching the continuity candidate schema v1.0.

See: `docs/continuity-progression-candidate-schema.md`

### Required top-level fields

| Field | Constraint |
|-------|-----------|
| `schema_version` | Must be `"1.0"` |
| `lane_id` | Must be `"continuity-progression-reasoning"` |
| `analysis_scope_type` | Must be `"adjacent_scene"` for this task |
| `analysis_scope_bounds` | Must include `scene_ids` array |
| `input_unit_ids` | Must be an array |
| `candidate_findings` | Must be an array (may be empty) |
| `overall_run_note` | Must be a non-empty string |
| `run_posture` | Must be `"candidate_only"` |

### Required per-finding fields

| Field | Constraint |
|-------|-----------|
| `finding_id` | Unique string, format `cpf-NNN` |
| `finding_label` | Non-empty, review-friendly string |
| `finding_type` | Approved enum value |
| `claim` | Candidate-framed; no authority language |
| `scope_type` | Approved enum; must not exceed run scope |
| `scope_bounds` | Must include `scene_ids`; must not reference out-of-scope scenes |
| `evidence_spans` | Array of at least 1 evidence object |
| `confidence` | `low`, `moderate`, or `high` |
| `uncertainty_note` | Substantive string; not "None" or empty |
| `review_note` | Actionable string; not "Review this" or empty |
| `candidate_state` | `candidate_unreviewed` for new output |

---

## Validation rules (hard-fail triggers)

The validator rejects output and triggers fail-closed if:

- Any required top-level field is missing
- `lane_id` does not match
- `schema_version` does not match
- `run_posture` is not `candidate_only`
- `analysis_scope_bounds` lacks `scene_ids`
- Any finding is missing a required field
- Any finding uses an unapproved `finding_type`
- Any finding uses an unapproved `confidence` value
- Any finding's `scope_bounds` references scenes outside the run scope
- Any finding has an empty `evidence_spans` array
- Any finding's `claim` contains authority language
- Any finding's `uncertainty_note` is empty or trivial
- Any finding's `review_note` is empty or trivial
- JSON cannot be parsed from model output

---

## Execution path

```
request packet
  → validate required fields
  → build model input (prompt + scene texts)
  → run HIGH_QUALITY_LOCAL model via ollama
  → extract JSON from raw output
  → validate against candidate schema v1.0
  → [fail] → fail-closed envelope (exit 1)
  → [pass] → candidate artifact envelope (exit 0)
  → log to registry (success only)
```

---

## Scripts

| Script | Purpose |
|--------|---------|
| `scripts/run-continuity-adjacent-scene.sh` | Main executor |
| `scripts/validate-continuity-candidate.py` | Schema validator |
| `scripts/render-continuity-candidate.sh` | Bloom-facing Markdown renderer |

---

## Prompts

| File | Purpose |
|------|---------|
| `prompts/continuity-adjacent-scene-v1.md` | Model system prompt for this task |

---

## Governance notes

- This contract is `v1`. Changes to required fields or validation rules require a version bump.
- Consumer code must bind to this contract, not to prompt internals.
- The prompt is hidden behind the contract boundary.
- Model selection is separate from the contract and governed by the route class policy.
