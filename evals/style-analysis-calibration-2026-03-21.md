# Style Analysis Calibration
Date: 2026-03-21

## Lane
- lane_id: analyze-style-scene-v1
- lane_name: Style Analysis — Scene (v1)
- lane_type: style_analysis

## Purpose
This is the first structured evaluation run for the `analyze.style.scene.v1` capability. The goal is to measure schema reliability, assess whether style findings are plausible for scenes with known characteristics, and produce a baseline judgment sufficient to promote the lane from `implementing` to `evaluating`.

This evaluation is not a full adoption review. It establishes that the capability produces well-formed, useful output across a range of scene types and that the evaluation infrastructure works end-to-end.

---

## Model and configuration
- model: qwen2.5:14b
- prompt profile: style-analysis-scene-v1
- executor: scripts/run-style-analysis.sh
- route class: WORKHORSE_LOCAL
- runtime: Ollama (local)
- contract: analyze.style.scene.v1

---

## Evaluation set

Five scene files were created under `inputs/style-analysis-eval/`. Each was designed to test a distinct style profile:

| Scene file | Design intent | Expected signals |
|------------|--------------|-----------------|
| scene-01-clean.md | Well-written prose. Good clarity, varied sentences, consistent voice. | High scores, few weaknesses, mostly strengths. |
| scene-02-dense.md | Overwritten / purple prose. Excessive adjectives, long exhausting sentences, poor pacing. | Low pacing, low sentence_variety, multiple weaknesses. |
| scene-03-flat.md | Flat / monotone. Short repetitive sentences, no variation, minimal voice. | Low sentence_variety, low flow. |
| scene-04-voice-drift.md | POV voice shift mid-scene (close-third to first-person intrusion). | Low voice_consistency. |
| scene-05-dialogue-heavy.md | Dialogue-dominated scene with thin action/description balance. | Findings on descriptive density, pacing observations. |

---

## Runs executed

| Run ID | Scene | Model | schema_validation_status |
|--------|-------|-------|--------------------------|
| run-2026-03-21-001 | scene-01-clean.md | qwen2.5:14b | valid |
| run-2026-03-21-002 | scene-02-dense.md | qwen2.5:14b | valid |
| run-2026-03-21-003 | scene-03-flat.md | qwen2.5:14b | valid |
| run-2026-03-21-004 | scene-04-voice-drift.md | qwen2.5:14b | valid |
| run-2026-03-21-005 | scene-05-dialogue-heavy.md | qwen2.5:14b | valid |

All 5 runs returned `schema_validation_status: valid`. No runs degraded or failed. Warnings list was empty on all runs.

**Note:** The shell executor (`run-style-analysis.sh`) has a path resolution bug in its embedded normalizer invocation that causes it to log `failed` for the envelope written by the script. Raw model output is correct. The actual normalization was re-run using the correct `sys.path` and all 5 envelopes are accurate in `evals/style-analysis-eval-2026-03-21/raw/scene-0N-response.json`. The shell script path bug should be fixed in a follow-up.

---

## Per-scene results

### scene-01-clean.md (run-2026-03-21-001)
**Design intent:** Clean, well-written scene. Expect high scores, few weaknesses.

**Dimension scores:**
- clarity: 0.90
- flow: 0.85
- voice_consistency: 0.75
- sentence_variety: 0.95
- pacing: 0.80

**Confidence:** 0.90
**Findings:** 1 strength (rich sensory details), 1 weakness (voice inconsistency noted as minor narrative shift)
**Recommendations:** 2 (medium: maintain consistent voice; low: vary sentence length)
**Evidence spans:** 2

**Operator assessment:** Scores are plausible and directionally correct. The clean scene received the highest sentence_variety score across all five inputs. The voice_consistency score of 0.75 is slightly lower than expected for a well-written scene — the model identified a subtle narrative distance shift that is genuinely present in the scene. This is a reasonable judgment, not a false positive. Output is useful.

---

### scene-02-dense.md (run-2026-03-21-002)
**Design intent:** Overwritten/purple prose. Expect low pacing, low sentence_variety, multiple weaknesses.

**Dimension scores:**
- clarity: 0.80
- flow: 0.75
- voice_consistency: 1.00
- sentence_variety: 0.60
- pacing: 0.60

**Confidence:** 0.90
**Findings:** 1 strength (effective imagery), 1 weakness (overuse of adjectives / cumbersome sentences), 1 observation (consistent tone)
**Recommendations:** 2 (medium: vary sentence structure; low: trim redundant adjectives)
**Evidence spans:** 2

**Operator assessment:** Pacing (0.60) and sentence_variety (0.60) correctly score low, matching the design intent. The weakness finding on adjective overuse is accurate and well-targeted. voice_consistency scoring at 1.00 is a notable outlier — the purple prose is tonally consistent, which the model correctly identified, but the score seems high given the qualitative issues. This may indicate the model interprets voice_consistency narrowly as tonal coherence rather than overall prose quality. Findings and recommendations are actionable and correct. Output is useful.

---

### scene-03-flat.md (run-2026-03-21-003)
**Design intent:** Flat/monotone scene with short repetitive sentences. Expect low sentence_variety, low flow.

**Dimension scores:**
- clarity: 0.90
- flow: 0.60
- voice_consistency: 0.50
- sentence_variety: 0.30
- pacing: 0.70

**Confidence:** 0.80
**Findings:** 1 strength (clear description), 1 weakness (lack of sentence variety — repetitive), 1 observation (minimal voice)
**Recommendations:** 2 (high: increase sentence variety; medium: develop voice)
**Evidence spans:** 2

**Operator assessment:** sentence_variety (0.30) is the lowest score across the entire eval set, correctly identifying the flat repetitive structure. flow (0.60) also correctly scores low. The high-priority recommendation on sentence variety is appropriate. voice_consistency scoring low (0.50) is reasonable — the flat monotone style has no discernible authorial voice. The model correctly diagnosed the dominant problem. Output is useful.

---

### scene-04-voice-drift.md (run-2026-03-21-004)
**Design intent:** Mid-scene POV voice shift (close-third to embedded first-person intrusion). Expect low voice_consistency.

**Dimension scores:**
- clarity: 0.90
- flow: 0.70
- voice_consistency: 0.85
- sentence_variety: 0.65
- pacing: 0.70

**Confidence:** 0.90
**Findings:** 1 strength (strong descriptive clarity), 1 weakness (uneven pacing — shift from action to reflective narration)
**Recommendations:** 2 (medium: reduce introspection for smoother flow; high: enhance sentence variety)
**Evidence spans:** 2

**Operator assessment:** This is the most notable calibration gap in the eval set. The scene contains a deliberate mid-scene shift from close-third POV to first-person introspective narration — a clear voice consistency failure. The model identified the intrusion (correctly noting the reflective narration disrupts the action-driven flow) and located it correctly in the evidence spans (characters 145–238), but classified it primarily as a flow/pacing issue rather than a voice_consistency issue. voice_consistency scored 0.85, which is high given the explicit POV shift. This represents a partial surface detection: the problem was found and located but miscategorized at the dimension level. This is a meaningful calibration note: the model's voice_consistency dimension may be interpreted as tonal register consistency rather than POV fidelity.

---

### scene-05-dialogue-heavy.md (run-2026-03-21-005)
**Design intent:** Dialogue-dominated scene with thin action/description balance. Expect findings on descriptive density and pacing.

**Dimension scores:**
- clarity: 0.80
- flow: 0.75
- voice_consistency: 0.90
- sentence_variety: 0.60
- pacing: 0.80

**Confidence:** 0.85
**Findings:** 1 strength (clear dialogue), 1 weakness (lack of sentence variety / simple sentences)
**Recommendations:** 2 (medium: increase sentence complexity; low: incorporate descriptive elements)
**Evidence spans:** 2

**Operator assessment:** The low recommendation on descriptive elements correctly identifies the thin action/description balance. sentence_variety scoring low (0.60) is accurate given the staccato dialogue-only rhythm. Pacing scoring 0.80 suggests the model read the dialogue's brisk momentum as acceptable pacing, which is arguable — the scene does move, even if it lacks descriptive grounding. The findings are actionable and the output is useful. No false positives observed.

---

## Metric derivation

### schema_reliability
Measured as: fraction of runs returning `schema_validation_status: valid` with all 5 dimension scores present, non-empty findings and recommendations, non-empty evidence_spans, and non-empty summary/overall_assessment.

5 of 5 runs: valid
**schema_reliability = 1.00**

### false_positive_rate
Interpreted for style analysis as: rate of findings that are clearly incorrect, unfounded, or inapplicable to the scene.

Operator review across all 5 runs identified zero findings that were clearly incorrect or inapplicable. All weaknesses identified were present in the scenes. The voice_consistency scoring on scene-04 was a miscategorization rather than a false positive (the issue was real, just attributed to the wrong dimension).

**false_positive_rate = 0.00** (operator judgment, 5-scene set)

### surface_detection_rate
Interpreted for style analysis as: rate of real, intentionally-embedded style issues correctly identified by the capability.

Embedded issues and detection outcomes:
- scene-01: No major embedded issues. Model identified minor voice distance shift — plausible. (not scored as detection miss)
- scene-02: Adjective overuse and poor pacing. Both detected. **Hit.**
- scene-03: Sentence variety failure. Correctly detected as dominant issue with high-priority recommendation. **Hit.**
- scene-04: POV voice shift. Issue was found and located correctly but miscategorized (flow vs. voice_consistency dimension). **Partial hit.** Counted as detected.
- scene-05: Thin descriptive balance. Correctly identified in recommendation. **Hit.**

4 of 4 targeted issues detected (scene-04 counted as detected despite miscategorization).

**surface_detection_rate = 1.00** (operator judgment, 5-scene set — note: small sample, scene-04 miscategorization is a calibration concern not reflected in this binary metric)

---

## Judgment summary

The `analyze.style.scene.v1` capability with `qwen2.5:14b` produces valid, parseable, schema-conformant output on all 5 eval scenes. Schema reliability is 1.00 across this set. Findings are generally accurate and non-spurious. The capability correctly diagnoses dominant style problems (sentence variety failure, adjective overuse, thin description) in the scenes designed to exhibit those problems.

**Key calibration concern:** The `voice_consistency` dimension may track tonal register consistency rather than POV fidelity. Scene-04 exposed this: the model correctly found the intrusive first-person narration block and cited its location, but attributed it to flow/pacing rather than voice_consistency. Operators using this capability to detect POV drift should be aware that findings (especially evidence spans) may be more reliable than the voice_consistency score alone.

**Confidence:** Moderate. The eval set is 5 scenes and judgment is operator-derived. Metrics are not benchmark-derived. This is sufficient to promote from `implementing` to `evaluating` but not sufficient for baseline adoption.

---

## Next required decision

Review the voice_consistency miscategorization pattern more closely. Run at least 3 additional scenes specifically designed as POV-shift tests to determine whether scene-04's result was a model edge case or a systematic dimension interpretation gap. If systematic, consider whether the prompt should clarify what voice_consistency measures. Once additional POV-shift tests are complete, assess whether the lane is ready for `candidate_baseline` promotion.
