# STORM Question Generation Guide

Purpose: Generate specific, grounded questions that drive meaningful knowledge gathering
Used by: warmstart-article.yaml (expert_conversations step)
GPT-5 Optimization: Focused guidance for single cognitive task (question formulation)

---

## Core Principle

Grounded questions are anchored to specific research findings, claims, or gaps. They invite experts to interpret, contextualize, or extend concrete information—not to free-associate.

Bad (generic): "What do you think about AI?"
Good (grounded): "Based on McKinsey's 2024 report showing 60% of firms piloting gen-AI but only 12% seeing ROI, what implementation barriers do you see from your CFO perspective?"

---

## Question Requirements

<question_requirements>

  1. Specificity: Reference exact source, statistic, or finding
  2. Targeting: Match question to expert's unique lens
  3. Progression: Build on previous answers; don't repeat
  4. Openness: Invite explanation/interpretation, not yes/no
  5. Actionability: Expert can answer with their expertise and web research
</question_requirements>

---

## Question Generation Process

### Input Sources (in priority order)

1. Background research findings (Round 1 primary source)
   - Key statistics, trends, or claims from background research
   - Contradictions or debates in the literature
   - Surprising findings or gaps noted in research summary

2. This expert's previous answers (Round 2+ primary source)
   - Claims that need elaboration
   - Tensions or trade-offs mentioned but not fully explored
   - New concepts introduced that warrant follow-up

3. Other experts' answers (Round 2+ secondary source)
   - Contrasting viewpoints that need this expert's perspective
   - Gaps in coverage that this expert can fill
   - Complementary angles that build on others' insights

4. Knowledge base coverage gaps (All rounds secondary source)
   - Sections with low citation density
   - Sections with only one expert perspective
   - Missing stakeholder viewpoints

### Selection Logic

Round 1: Start with most salient finding from background research that this expert is positioned to interpret
Round 2: Follow up on this expert's most interesting claim or tension from Round 1
Round 3: Either (a) go deeper on Round 2 thread OR (b) address a gap or contrast with other experts
Round 4 (if needed): Tying loose ends, addressing any critical gaps in this expert's domain

---

## Question Templates

### Template 1: Interpretation Request

```text
"Based on [SOURCE/FINDING showing STATISTIC/TREND],
from your perspective as [EXPERT ROLE],
[HOW DO YOU INTERPRET / WHAT EXPLAINS / WHAT CONCERNS] this?"
```

Example:
"Based on the Stanford AI Index 2024 showing private sector AI investment at $90B vs. academic funding at $4B, from your perspective as a university AI researcher, what does this funding imbalance mean for research independence?"

---

### Template 2: Trade-off Exploration

```text
"[EXPERT NAME] mentioned [CLAIM/TENSION].
From your [DIFFERENT ROLE/PERSPECTIVE],
how do you navigate the trade-off between [X] and [Y]?"
```

Example:
"Dr. Chen mentioned the tension between model performance and interpretability in medical AI. From your perspective as a hospital CIO responsible for clinical deployment, how do you navigate this trade-off when selecting diagnostic tools?"

---

### Template 3: Implementation/Application

```text
"Given [FINDING/CONSTRAINT],
from your [PRACTITIONER/POLICY ROLE],
what does successful implementation of [X] look like in practice?"
```

Example:
"Given that GDPR fines for algorithmic discrimination now average €12M, from your perspective as a Chief Compliance Officer, what governance structures are companies actually implementing to mitigate AI compliance risk?"

---

### Template 4: Stakeholder Impact

```text
"The research shows [TREND/DEVELOPMENT].
From your work with [STAKEHOLDER GROUP],
how is this affecting [SPECIFIC POPULATION/OUTCOME]?"
```

Example:
"The research shows automated hiring tools are now used by 70% of Fortune 500 companies. From your work with job seekers from underrepresented communities, how is this shift affecting their application experiences and outcomes?"

---

### Template 5: Gap-Filling

```text
"We've discussed [ASPECTS ALREADY COVERED].
What we haven't addressed yet is [GAP].
From your [EXPERTISE], what should we understand about [GAP]?"
```

Example:
"We've discussed the technical capabilities and business ROI of AI analytics. What we haven't addressed yet is organizational readiness. From your expertise in change management, what cultural blockers prevent AI adoption even when the tech is sound?"

---

### Template 6: Reconciliation

```text
"[EXPERT A] argued [POSITION A], while [EXPERT B] emphasized [POSITION B].
From your [THIRD PERSPECTIVE],
how do you reconcile these views / what's missing from this debate?"
```

Example:
"Dr. Martinez argued for rapid AI deployment to capture learning curves, while Prof. O'Brien emphasized precautionary principles given unknowable risks. From your regulatory economics perspective, what policy frameworks can accommodate both innovation and risk mitigation?"

---

## Question Quality Checklist

Before asking the question, verify:

- [ ] Grounded: References specific source, statistic, finding, or previous expert claim
- [ ] Targeted: Matches this expert's role/perspective (couldn't be asked to just anyone)
- [ ] Progressive: Doesn't repeat questions already asked to this expert
- [ ] Answerable: Expert can answer with their expertise + web research
- [ ] Open-ended: Invites >100 word response with reasoning
- [ ] Clear: Question is unambiguous; expert knows what you're asking

---

## Examples: Bad vs. Good Questions

### Example 1: AI in Healthcare

Bad: "What's your view on AI in healthcare?"

- Not grounded (no specific finding)
- Not targeted (could ask anyone)
- Too broad (infinite possible answers)

Good: "Based on JAMA's 2024 study showing AI diagnostic tools match radiologist accuracy on chest X-rays but face 30% clinician adoption rates, from your perspective as a practicing radiologist, what workflow or trust issues explain this uptake gap?"

- Grounded in JAMA study with specific findings
- Targeted to radiologist's clinical perspective
- Specific angle: adoption gap despite performance parity
- Answerable with expertise + research

---

### Example 2: Climate Policy

Bad: "What should we do about climate change?"

- Not grounded
- Not targeted to expert
- Too broad

Good: "The IEA's 2024 report shows renewables will generate 35% of global electricity by 2025, yet fossil fuel subsidies remain at $7T annually. From your work advising developing nations on energy policy, how do countries balance transition incentives with energy security concerns?"

- Grounded in IEA statistics
- Targeted to policy advisor for developing nations
- Specific tension: subsidies vs. transition
- Answerable with regional policy expertise

---

### Example 3: Follow-up Question (Round 2)

Context: Expert (a product manager) in Round 1 said: "User research is deprioritized when engineering teams are under pressure to ship."

Bad follow-up: "Can you elaborate?"

- Not grounded (no new information)
- Vague (elaborate on what specifically?)

Good follow-up: "You mentioned user research gets deprioritized under shipping pressure. From your work at a scaling startup, what specific incentive structures or metrics would you change to protect research time during crunch periods?"

- Grounded in their Round 1 claim
- Targeted to their specific experience (scaling startup)
- Actionable angle: incentive structures
- Invites concrete, practical answer

---

## Common Anti-Patterns

### Anti-Pattern 1: The Oracle Question

"What's the future of [X]?"

- Too speculative, invites hand-waving
- Not grounded in current evidence

Fix: "Based on [current trend/development], what trajectory do you anticipate for [specific aspect] over [timeframe]?"

---

### Anti-Pattern 2: The Yes/No Question

"Do you think [policy/tech] will work?"

- Invites single-word answer
- Not grounded in specific context

Fix: "Given [constraint/finding], what conditions would need to hold for [policy/tech] to succeed in [context]?"

---

### Anti-Pattern 3: The Double-Barreled Question

"What are the benefits and drawbacks, and how should we weigh them, and what would you recommend?"

- Three questions in one
- Cognitively overloading

Fix: Pick one. "Based on [finding], what's the primary trade-off you see, and how do you navigate it?"

---

### Anti-Pattern 4: The Leading Question

"Don't you think [X] is a problem?"

- Assumes conclusion
- Not open to genuine expert interpretation

Fix: "How do you assess [X] given [evidence]?"

---

### Anti-Pattern 5: The Untargeted Question

"What do experts in your field think about this?"

- Asking expert to speculate about others' views
- Not leveraging this expert's unique perspective

Fix: "From your [specific role/experience], how do you [interpret/approach/prioritize] this?"

---

## Progressive Questioning Strategies

### Round 1: Establish Foundation

- Pick the most salient/surprising finding from background research
- Ask expert to interpret through their lens
- Goal: Establish their core perspective

Example: "Based on [key finding], from your [role], how do you interpret this?"

---

### Round 2: Deepen or Contrast

Option A: Deepen (if Round 1 surfaced interesting tension)

- Follow up on most interesting claim/tension from Round 1
- Ask for elaboration, examples, or mechanisms

Example: "You mentioned [tension from R1]. Can you walk through how [specific mechanism/case]?"

Option B: Contrast (if other experts already interviewed)

- Present contrasting view from another expert
- Ask this expert to respond or reconcile

Example: "[Other expert] argued [X]. From your perspective, what's missing from that analysis?"

---

### Round 3: Apply or Extend

Option A: Application

- Ask how their insights apply to specific context/case
- Move from abstract to concrete

Example: "Given what you've said about [principle], how would you apply this to [specific scenario]?"

Option B: Extension

- Ask about implications, second-order effects, or future projections
- Build on established foundation

Example: "Building on your point about [X], what does this mean for [related domain/stakeholder]?"

---

### Round 4 (if needed): Tie Loose Ends

- Address any critical gap in this expert's domain
- Reconcile any contradictions in their answers
- Connect their insights to broader article narrative

Example: "Before we conclude, one area we haven't covered from your perspective is [gap]. How do you see [gap] relating to [main topic]?"

---

## Usage Notes

1. Prepare questions in batches: Before starting an expert conversation, draft potential questions for all 3-4 rounds based on background research and expert profile. Adapt as needed based on answers.

2. One question per round: Don't overwhelm expert with multiple questions. Focus yields depth.

3. Reference liberally: Name sources, cite stats, quote other experts. Grounding builds credibility.

4. Target the lens: Every question should leverage this specific expert's unique perspective. If the question could be asked to anyone, it's not targeted enough.

5. Track coverage: Note which knowledge base sections each question targets. Aim for comprehensive coverage across experts.

---

## Integration with Knowledge Base

After each expert answer, the question and answer will be:

1. Recorded in conversation_log (for transparency)
2. Decomposed into facts for knowledge_base.yaml
3. Analyzed for coverage gaps to inform next questions

The question generation process is thus informed by and feeds into the evolving knowledge base.
