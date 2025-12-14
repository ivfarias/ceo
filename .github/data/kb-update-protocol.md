# STORM Knowledge Base Update Protocol

**Purpose**: Standardize incremental KB updates after each expert answer
**Used by**: warmstart-article.yaml (expert_conversations step)
**GPT-5 Optimization**: Clear procedure for single task (KB update)

---

## Update Frequency

**Critical**: Update knowledge_base.yaml **immediately after EACH expert answer**, not in batch at end.

**Why**: Incremental updates ensure:
- No information loss
- Coverage gaps are visible for next question
- KB is always current source of truth

---

## Update Process

After each expert answer, execute these steps in order:

```
1. Extract Claims
   ↓
2. Assign to Sections
   ↓
3. Generate Fact Entries
   ↓
4. Record Perspectives
   ↓
5. Add Citations
   ↓
6. Update Statistics
```

---

## Step 1: Extract Claims

<extract_claims>
  **Goal**: Identify discrete factual claims or insights from expert answer

  **What to extract**:
  - Factual claims backed by citations
  - Expert interpretations or frameworks
  - Quantitative data or statistics
  - Mechanisms, processes, or causal claims
  - Tensions, trade-offs, or limitations identified
  - Stakeholder impacts or concerns

  **What to skip**:
  - Conversational filler ("Thank you for the question...")
  - Pure opinion without reasoning ("I believe X is good")
  - Information already in KB (check for duplicates)

  **Example Expert Answer**:
  "Based on the 2024 WHO report, AI diagnostic adoption grew 40% year-over-year, driven primarily by radiology and pathology departments [1]. However, from my clinical ethics perspective, consent frameworks haven't kept pace—most patients don't understand when AI is involved in their diagnosis [2]. This creates a transparency gap that risks eroding trust."

  **Extracted Claims**:
  1. AI diagnostic adoption grew 40% YoY (WHO 2024) [quantitative finding]
  2. Growth concentrated in radiology and pathology departments [domain-specific finding]
  3. Consent frameworks lag behind adoption (medical ethics perspective) [gap/tension]
  4. Most patients unaware of AI involvement in diagnosis [stakeholder impact]
  5. Transparency gap risks eroding patient trust [second-order effect]
</extract_claims>

---

## Step 2: Assign to Sections

<assign_to_sections>
  **Goal**: Map each claim to appropriate outline section in KB

  **Process**:
  1. Review existing `outline:` in knowledge_base.yaml
  2. For each claim, identify most relevant section
  3. If no section fits, create new section with clear title and scope

  **Section Assignment Logic**:
  - **Background/Overview**: Definitions, historical context, scope
  - **Current State**: Adoption rates, market size, key players
  - **Technical Details**: How it works, architectures, capabilities
  - **Applications**: Use cases, domain-specific deployment
  - **Challenges/Barriers**: Obstacles, limitations, failures
  - **Ethical/Social Impact**: Stakeholder concerns, equity, risks
  - **Policy/Governance**: Regulations, frameworks, standards
  - **Future Outlook**: Trends, projections, emerging developments

  **Example Assignments** (from claims above):
  - Claim 1 (40% growth) → "Current State" or "Adoption Trends"
  - Claim 2 (radiology/pathology) → "Applications" or "Clinical Deployment"
  - Claim 3 (consent frameworks lag) → "Ethical/Social Impact" or "Governance Gaps"
  - Claim 4 (patient awareness) → "Ethical/Social Impact" → "Patient Perspectives"
  - Claim 5 (trust erosion risk) → "Ethical/Social Impact" → "Trust and Transparency"

  **Creating New Sections**:
  If a claim doesn't fit existing sections, add new section to outline:
  ```yaml
  outline:
    - section_id: "ethics_transparency"
      title: "Trust and Transparency Challenges"
      scope: "Patient awareness, consent frameworks, clinician disclosure practices"
      subsections: []
  ```
</assign_to_sections>

---

## Step 3: Generate Fact Entries

<generate_fact_entries>
  **Goal**: Create structured fact records in knowledge_base.yaml

  **Fact Entry Template**:
  ```yaml
  facts_db:
    - fact_id: "fact_028"
      claim: "[The specific factual claim or finding]"
      section_id: "[Assigned section]"
      confidence: "high" | "medium" | "low"
      citations: [cite_042, cite_043]
      expert_perspectives:
        - expert_id: "expert_002"
          viewpoint: "[How this expert interprets/frames the fact]"
          quote: "[Optional: exact quote from answer]"
      related_facts: [fact_015, fact_021]  # Optional: links to related facts
      tags: ["adoption", "clinical", "ethics"]  # Optional: for searchability
  ```

  **Confidence Levels**:
  - **high**: Claim from authoritative source (peer-reviewed, official stats, established consensus)
  - **medium**: Claim from reputable source but not peer-reviewed, or expert interpretation of solid data
  - **low**: Claim from limited source, expert opinion without strong backing, or emerging/contested finding

  **Example Fact Entries**:
  ```yaml
  facts_db:
    - fact_id: "fact_028"
      claim: "AI diagnostic adoption grew 40% year-over-year as of 2024, primarily in radiology and pathology"
      section_id: "clinical_adoption"
      confidence: "high"
      citations: [cite_042]  # WHO 2024 report
      expert_perspectives:
        - expert_id: "expert_003"  # Medical ethicist
          viewpoint: "Highlights rapid deployment outpacing governance frameworks"
      tags: ["adoption", "growth", "radiology", "pathology"]

    - fact_id: "fact_029"
      claim: "Consent frameworks for AI-assisted diagnosis have not kept pace with technology adoption"
      section_id: "ethics_transparency"
      confidence: "medium"
      citations: [cite_043]  # Medical ethics article
      expert_perspectives:
        - expert_id: "expert_003"
          viewpoint: "Critical governance gap; patients often unaware AI is involved"
          quote: "Most patients don't understand when AI is involved in their diagnosis"
      related_facts: [fact_028]  # Links to adoption fact
      tags: ["consent", "ethics", "governance", "transparency"]

    - fact_id: "fact_030"
      claim: "Lack of transparency about AI involvement in diagnosis may erode patient trust"
      section_id: "ethics_transparency"
      confidence: "medium"
      citations: [cite_043]
      expert_perspectives:
        - expert_id: "expert_003"
          viewpoint: "Second-order risk stemming from consent gaps"
      related_facts: [fact_029]
      tags: ["trust", "transparency", "patient-experience"]
  ```
</generate_fact_entries>

---

## Step 4: Record Perspectives

<record_perspectives>
  **Goal**: Capture how each expert interprets or frames the facts

  **Why perspectives matter**:
  - Same fact can be framed differently by different experts
  - Multi-perspective synthesis requires tracking viewpoints
  - Enables balanced article that acknowledges different interpretations

  **Perspective Entry Components**:
  - `expert_id`: Links to expert profile
  - `viewpoint`: How this expert frames/interprets the fact (1-2 sentences)
  - `quote`: (Optional) Exact quote from answer if particularly illustrative

  **Example - Same Fact, Different Perspectives**:
  ```yaml
  - fact_id: "fact_031"
    claim: "70% of Fortune 500 companies now use automated hiring tools"
    section_id: "enterprise_adoption"
    confidence: "high"
    citations: [cite_044]
    expert_perspectives:
      - expert_id: "expert_001"  # HR Tech Analyst
        viewpoint: "Market maturation indicator; signals shift from early adoption to mainstream deployment"

      - expert_id: "expert_004"  # Civil Rights Advocate
        viewpoint: "Scale of deployment makes algorithmic bias a systemic risk affecting millions of job seekers"

      - expert_id: "expert_005"  # CHRO
        viewpoint: "Efficiency gains are real but cultural resistance from hiring managers remains a blocker"
  ```

  This multi-perspective capture enables synthesis that presents the fact with its varied interpretations.
</record_perspectives>

---

## Step 5: Add Citations

<add_citations>
  **Goal**: Maintain citation database with full provenance

  **Citation Entry Template**:
  ```yaml
  citations:
    - cite_id: "cite_042"
      title: "[Full article/report title]"
      url: "[Full URL]"
      source: "[Publisher/Organization]"
      date: "[Publication date YYYY-MM-DD]"
      access_date: "[Date you accessed it YYYY-MM-DD]"
      tier: 1  # Use research tier system (1=best, 4=lowest)
      cited_by_experts: ["expert_003"]
      cited_in_facts: ["fact_028"]
  ```

  **Tier System** (matches research policy):
  - **Tier 1**: Academic/Institutional (.edu, .gov, NGOs, peer-reviewed journals)
  - **Tier 2**: Major News & Reference (Reuters, BBC, NYT, WSJ, Economist, Britannica)
  - **Tier 3**: Professional/Industry (HBR, McKinsey, reputable trade publications, expert Substacks)
  - **Tier 4**: Community/Anecdotal (Reddit, LinkedIn posts, personal blogs)

  **Example**:
  ```yaml
  citations:
    - cite_id: "cite_042"
      title: "Global Health AI Adoption Report 2024"
      url: "https://www.who.int/publications/i/item/ai-adoption-2024"
      source: "World Health Organization"
      date: "2024-03-15"
      access_date: "2024-12-01"
      tier: 1
      cited_by_experts: ["expert_003"]
      cited_in_facts: ["fact_028"]
  ```
</add_citations>

---

## Step 6: Update Statistics

<update_statistics>
  **Goal**: Maintain KB metadata for tracking coverage

  **Update these fields in knowledge_base.yaml**:
  ```yaml
  statistics:
    total_facts: 30  # Increment by number of facts added
    total_citations: 45  # Increment by number of new citations
    total_sections: 8  # Increment if new sections created
    expert_contributions:
      expert_001: 12  # Increment by facts contributed by this expert
      expert_002: 8
      expert_003: 10  # <-- Update this after processing expert_003's answer
    coverage_completeness: 0.75  # Recalculate: facts_with_citations / total_facts
    perspective_diversity: 2.1  # Recalculate: avg perspectives per fact
  ```

  **Calculations**:
  - `total_facts`: Simple count of `facts_db` entries
  - `total_citations`: Simple count of `citations` entries (deduplicated)
  - `expert_contributions[expert_id]`: Count facts where expert appears in `expert_perspectives`
  - `coverage_completeness`: Ratio of facts with at least 1 citation to total facts
  - `perspective_diversity`: Average number of expert perspectives per fact
</update_statistics>

---

## Special Cases

### Case 1: Duplicate Information

**If expert says something already in KB**:
1. Check if it's truly identical or slightly different framing
2. If identical: Don't create new fact, but ADD this expert's perspective to existing fact
3. If different framing: Create new fact and link via `related_facts`

**Example**:
Expert A: "AI adoption grew 40% in 2024"
Expert B: "Hospitals deployed AI diagnostics at record rates last year"

→ Same underlying fact, Expert B's framing adds hospital-specific context
→ Add Expert B's perspective to existing fact_028, optionally create linked fact for "hospital" angle

---

### Case 2: Contradictory Claims

**If expert contradicts existing fact**:
1. Create new fact entry for the contradictory claim
2. Link via `related_facts` to the original
3. Add tag: "contested" or "contradiction"
4. Both facts remain in KB; synthesis step will handle reconciliation

**Example**:
Fact_028: "AI improves diagnostic accuracy by 15%" [cite: academic study]
Fact_035: "Real-world AI diagnostic accuracy gains are marginal" [cite: practitioner interview]

→ Both recorded, linked, tagged "contested"
→ Synthesis will present both views: "While lab studies show X, practitioners report Y"

---

### Case 3: Expert Opinion Without Source

**If expert makes claim without citing source**:
1. Note in fact entry: `confidence: low`
2. In `expert_perspectives`, note it's "expert opinion" or "based on experience"
3. During synthesis, frame as "[Expert] argues..." not "Research shows..."

**Example**:
Expert says: "In my experience, most AI projects fail due to data quality issues"
→ Record as fact, confidence: medium, note as "practitioner experience"
→ Try to find supporting research in next web search; if found, upgrade confidence and add citation

---

### Case 4: Organizing Subsections

**If a section accumulates 10+ facts**:
1. Review facts for natural clusters
2. Create subsections in outline
3. Reassign fact `section_id` to subsections

**Example**:
Section "Ethical Challenges" has 15 facts covering: bias, privacy, consent, transparency, accountability

→ Create subsections:
```yaml
- section_id: "ethics"
  title: "Ethical and Social Challenges"
  subsections:
    - subsection_id: "ethics_bias"
      title: "Algorithmic Bias and Fairness"
    - subsection_id: "ethics_privacy"
      title: "Privacy and Data Protection"
    - subsection_id: "ethics_transparency"
      title: "Transparency and Consent"
```

→ Reassign facts to appropriate subsections

---

## Quality Checks

Before moving to next round, verify:

- [ ] All claims from expert answer extracted
- [ ] Each claim assigned to section (new sections created if needed)
- [ ] Fact entries include: claim, section, confidence, citations, expert perspective
- [ ] Citations include: title, URL, source, tier, access date
- [ ] Statistics updated: total_facts, total_citations, expert_contributions
- [ ] No information from expert answer lost
- [ ] KB is valid YAML (no syntax errors)

---

## Tool Preambles for KB Updates

<tool_preambles>
  **After each expert answer**:
  "Extracting [N] claims from [Expert Name]'s answer. Adding to sections: [list]. Total KB facts now: [total]. Moving to next round."

  **Example**:
  "Extracting 5 claims from Dr. Martinez's answer. Adding to sections: Clinical Adoption, Ethics & Transparency. Total KB facts now: 30. Citations: 45. Moving to Round 2."
</tool_preambles>

---

## Integration with Next Steps

The updated KB is immediately used for:
1. **Gap Analysis**: Identifying under-covered sections for next questions
2. **Question Generation**: Grounding next questions in KB facts
3. **Cross-Expert Synthesis**: Showing Expert B what Expert A said
4. **Coverage Tracking**: Ensuring comprehensive topic treatment

The KB is the **living memory** of the research process. Keep it current.

---

## Anti-Patterns

**Never**:
- Batch KB updates at the end of all conversations
- Skip recording expert perspectives (just facts)
- Omit confidence levels or tier ratings
- Create facts without section assignments
- Let KB get out of sync with conversation state

**Always**:
- Update KB immediately after each answer
- Record both fact and expert's framing of it
- Maintain citation provenance with full URLs
- Check for duplicates before adding new facts
- Keep statistics current for coverage tracking
