# STORM Conversation Protocol

**Purpose**: Execute multi-round expert interviews with voice simulation
**Used by**: warmstart-article.yaml (expert_conversations step)
**GPT-5 Optimization**: Modular protocol with clear persistence rules

---

## Protocol Overview

Each expert conversation consists of 3-4 rounds where:
1. **You (as moderator)** generate grounded questions based on previous answers and research
2. **You (as expert)** simulate the expert's voice, conduct web research, and answer
3. **You (as curator)** extract facts and update knowledge base incrementally

---

## Round Execution Flow

```
┌─────────────────────────────────────────────────────┐
│ Round N (repeat 3-4 times per expert)              │
├─────────────────────────────────────────────────────┤
│ 1. Generate Question (as moderator)                │
│    ↓                                                 │
│ 2. Research & Answer (as expert)                   │
│    ↓                                                 │
│ 3. Update Knowledge Base (as curator)              │
│    ↓                                                 │
│ 4. Check if ready for next round or next expert    │
└─────────────────────────────────────────────────────┘
```

---

## Step 1: Generate Question (as moderator)

<question_generation>
  **Role**: Interview moderator seeking to deepen understanding

  **Input Sources**:
  - Background research findings
  - Previous answers from this expert (if Round 2+)
  - Answers from other experts (to find gaps or contrasts)
  - Current knowledge base coverage gaps

  **Question Requirements**:
  - **Grounded**: Reference specific finding, claim, or gap from research
  - **Targeted**: Ask about specific aspect this expert is positioned to answer
  - **Progressive**: Build on previous rounds; don't repeat
  - **Open-ended**: Invite explanation, not yes/no

  **Question Template**:
  ```
  "Based on [SOURCE/FINDING], [SPECIFIC DETAIL].
  From your perspective as [EXPERT ROLE], [QUESTION]?"
  ```

  **Examples**:
  - ✅ "Based on the 2024 WHO report showing 40% increase in AI diagnostic adoption, from your perspective as a medical ethicist, what consent frameworks should hospitals prioritize?"
  - ❌ "What do you think about AI in healthcare?" (too generic, not grounded)

  **Reference**: See `.claude/templates/storm-question-generation-guide.md` for detailed question formulation guidance
</question_generation>

---

## Step 2: Research & Answer (as expert)

<expert_simulation>
  **Role Switch**: You are now the expert (not the moderator)

  **Process**:
  1. **Load expert profile**: Review their role, perspective, expertise, potential biases
  2. **Conduct web research**: Use web.search to find 3-5 current, relevant sources
  3. **Filter through expert lens**: Interpret findings through this expert's viewpoint
  4. **Formulate answer**: Respond in expert's voice with citations

  **Voice Simulation Guidelines**:
  - **Frame through their lens**: Use their priorities, vocabulary, typical concerns
  - **Show their biases**: Let their perspective shape interpretation (within reason)
  - **Use discipline-specific language**: Natural use of field terminology
  - **Cite evidence**: Ground answer in web research, but filtered through expert viewpoint
  - **Length**: 3-5 paragraphs (150-250 words) with 2-4 inline citations

  **Answer Structure**:
  ```markdown
  [1-2 sentence direct response to question]

  [2-3 sentences elaborating with evidence and expert framing - cite sources]

  [1-2 sentences acknowledging tensions, trade-offs, or limitations from expert POV]

  [Optional: 1 sentence connecting to broader implications]

  **Sources**:
  - [Source 1 title and URL]
  - [Source 2 title and URL]
  ```
</expert_simulation>

---

## Step 3: Update Knowledge Base (as curator)

<kb_update_protocol>
  **Role Switch**: You are now the knowledge curator

  **Immediately after each expert answer**, update knowledge_base.yaml:

  1. **Extract factual claims** from the answer
  2. **Assign to outline sections** (create new sections if needed)
  3. **Generate fact entries** with citations
  4. **Record expert perspective** on each fact
  5. **Add new citations** to citations database
  6. **Update statistics**

  **Reference**: See `.claude/templates/storm-kb-update-protocol.md` for detailed KB update procedures

  **Critical Rule**: Update KB incrementally after EACH answer, not in batch at the end
</kb_update_protocol>

---

## Step 4: Round Termination

<round_completion>
  **After updating KB, decide**:

  **Continue with this expert** (next round) if:
  - Fewer than 3 rounds completed with this expert
  - Significant new information emerged that opens new questions
  - Coverage gaps remain in this expert's domain

  **Move to next expert** if:
  - 3-4 rounds completed with current expert
  - Diminishing returns (answers becoming repetitive)
  - This expert's perspective is well-captured in KB

  **Persistence Rule**: Default to continuing until 3 rounds per expert unless clear redundancy
</round_completion>

---

## Expert Voice Simulation Guide

### Voice Markers by Archetype

**Researcher**:
- Vocabulary: "The evidence suggests...", "Studies show...", "According to [citation]..."
- Hedging: Uses confidence levels ("likely", "preliminary findings", "requires further study")
- Methods focus: References sample sizes, methodologies, peer review
- Example: "Based on the randomized controlled trial by Smith et al. (2024), the intervention showed moderate effect size (d=0.42, p<0.05), though generalizability to non-WEIRD populations remains unclear."

**Practitioner**:
- Vocabulary: "In my experience...", "What works in practice...", "The challenge is..."
- Pragmatic: Discusses constraints, trade-offs, implementation realities
- Case-based: Uses examples from their work
- Example: "We piloted this approach with three clients last year. While theoretically sound, the operational overhead proved prohibitive for SMBs without dedicated compliance teams."

**Policy Maker**:
- Vocabulary: "From a regulatory standpoint...", "The policy challenge is...", "Balancing..."
- Systems thinking: Considers second-order effects, stakeholder interests
- Precedent: References existing frameworks, international standards
- Example: "Drawing on the EU's AI Act framework, we need to balance innovation incentives with accountability mechanisms—similar to how GDPR phased implementation allowed for industry adaptation."

**Advocate**:
- Vocabulary: "Communities we serve...", "From a justice perspective...", "This impacts..."
- Values-explicit: Names values and power dynamics
- Centering lived experience: Brings in voices of affected populations
- Example: "What's missing from this technocentric discussion is how automated systems perpetuate existing inequities. The communities bearing algorithmic harm—low-income, Black and Brown neighborhoods—weren't at the table when these tools were designed."

**Technologist**:
- Vocabulary: "Technically feasible...", "The architecture...", "Emerging capabilities..."
- Precision: Specific about technical details and limitations
- Future-oriented: Discusses what's possible vs. what exists today
- Example: "Current transformer architectures can handle this, but you'd need ~10⁸ parameters for production-grade performance. The cost-latency trade-off makes edge deployment impractical for now, though quantization techniques are improving rapidly."

---

## Conversation Quality Checklist

After each round, verify:
- [ ] Question was grounded in specific source/finding
- [ ] Question was targeted to this expert's unique perspective
- [ ] Expert answer conducted new web research (2-4 citations)
- [ ] Expert voice was authentic to their archetype
- [ ] Answer surfaced new information (not rehashing background research)
- [ ] KB was updated immediately after answer
- [ ] At least 2 new facts added to KB
- [ ] Expert perspective recorded on facts

---

## Persistence Rules

<persistence>
  **Autonomous Execution**:
  - Complete all 3-4 rounds for an expert before asking user for input
  - If research yields no new information, document this and proceed to next expert
  - Don't stop mid-conversation to ask user if you should continue

  **When to Escalate to User**:
  - Topic scope is fundamentally unclear after 1 expert's full conversation
  - Web research consistently fails (no sources found for multiple queries)
  - Contradiction between sources is irreconcilable

  **Otherwise**: Continue autonomously through all experts and all rounds
</persistence>

---

## Tool Preambles

<tool_preambles>
  **Before starting expert conversation**:
  "Starting conversation with [Expert Name] ([Role]). Will conduct 3-4 rounds covering [focus areas]. Expect to generate [X] questions and update KB incrementally."

  **After each round**:
  "Round [N] complete. Added [X] facts to KB under sections [list]. Moving to round [N+1] / next expert."

  **After full expert conversation**:
  "Completed [Expert Name] conversation. [X] facts added, [Y] citations collected. KB sections updated: [list]. Moving to next expert."
</tool_preambles>

---

## Anti-Patterns

**Never**:
- Ask generic, un-grounded questions
- Simulate expert answers without web research
- Batch KB updates (update after each answer)
- Continue beyond 4 rounds per expert without new info
- Stop mid-expert to ask user if you should continue

**Always**:
- Ground questions in specific sources/findings
- Conduct fresh web research for each expert answer
- Update KB immediately after each answer
- Maintain distinct expert voices
- Complete 3-4 rounds per expert unless clear redundancy

---

## Usage Notes

1. **Conversation pacing**: Aim for 3 rounds per expert (minimum 2, maximum 4)
2. **Progressive depth**: Each round should go deeper or explore new facet
3. **Cross-expert synthesis**: Later experts can reference earlier experts' points
4. **Voice consistency**: Maintain expert voice throughout their conversation
5. **KB as source of truth**: Always update KB immediately; it's your memory
