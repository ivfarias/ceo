# Codex Optimization Best Practices

**Version:** 1.0
**Optimized for:** gemini-2.5-pro with reasoning_effort: medium, verbosity: low
**Purpose:** Reference guide for Prepper agent when optimizing agents, tasks, and checklists

---

## Core Optimization Principles

### 1. Evidence-Based Changes Only
- **Never guess** — If context is missing, request it explicitly
- **Link to analysis** — Every proposed change must cite analysis_report findings
- **Verify before propose** — Use context7 MCP to validate tech stack references
- **Document unknowns** — Flag gaps rather than making assumptions

### 2. One-at-a-Time Processing
- **NEVER batch optimize** — Process exactly one artifact per interaction
- **Stop for confirmation** — Always await user approval before applying changes
- **Maintain context** — Reuse analysis_report across optimization steps
- **Track progress** — Update progress_table after each item

### 3. Minimal Disruption
- **Preserve structure** — Maintain original formatting unless fixing errors
- **Incremental changes** — Propose small, focused improvements
- **Backward compatibility** — Ensure changes don't break existing workflows
- **Rollback ready** — Store rollback_notes for every applied change

---

## Gemini Optimization Strategies

### Reasoning Control Patterns
```yaml
reasoning_control: |
  <reasoning_control>
  - reasoning_effort: medium  # Default for most Codex tasks
  - uncertainty_tolerance: low  # Confirm when unclear
  - prefer_act_over_ask: false  # Safety-first in optimization flows
  - termination_policy: "Stop after each artifact for confirmation"
  - early_exit_ok: false
  </reasoning_control>
```

**Why this works:**
- `medium` effort balances thoroughness with token efficiency
- `low` uncertainty ensures no guessing during critical changes
- `prefer_act_over_ask: false` prevents premature modifications
- Explicit termination policy enforces one-at-a-time orchestration

### Session Memory for Gemini
```yaml
session_memory: |
  <session_memory>
  - use_responses_api: true
  - include_previous_response_id: true
  - reuse_reasoning_context: true
  - persist_keys: ["analysis_report", "progress", "active_artifact", "audit_log"]
  </session_memory>
```

**Why this works:**
- Responses API maintains long-term context across optimization sequences
- Reused reasoning prevents re-analyzing same evidence
- Persisted keys enable pause/resume workflows
- Reduces token usage by ~30% in multi-step optimizations

### Structured Tool Preambles
```yaml
tool_preambles: |
  <tool_preambles>
  - Before reading: Restate goal and why file matters
  - During: Announce completion or blockers succinctly
  - After: Summarize changes and present numbered options
  </tool_preambles>
```

**Why this works:**
- Gemini performs better with explicit step announcements
- Pre-stating goals improves reasoning trace quality
- Post-summaries reduce user confusion in long sequences

---

## Agent Optimization Patterns

### Model Alignment
✅ **DO:**
```yaml
metadata:
  model: gemini-2.5-pro
  model_controls:
    reasoning_effort: medium
    verbosity: low
```

❌ **DON'T:**
```yaml
metadata:
  model: gemini-2.5-flash  # Outdated
  temperature: 0.7    # Use model_controls instead
```

### Dependency Validation
✅ **DO:**
```yaml
dependencies:
  tasks:
    - analyze-project-context.yaml
  templates:
    - project-analysis-tmpl.yaml
```
- Verify all referenced files exist in `.codex/` structure
- Use context7 to validate external library dependencies

❌ **DON'T:**
- Reference tasks/templates that don't exist
- Assume dependencies without checking analysis_report

### Command Definitions
✅ **DO:**
```yaml
commands:
  - help: Show numbered list of commands
  - analyze: Run analysis (exec task-file.yaml)
  - optimize: Start optimization workflow
```
- Keep command names short and memorable
- Include brief description of what command does
- Link to executable task files where applicable

---

## Task Optimization Patterns

### Context7 Integration (CRITICAL)
✅ **DO:**
```yaml
- id: gather_context
  type: checklist
  items:
    - label: "Tech stack + versions"
      required: true
      action: use_context7_mcp
```

**Why:** Ensures tasks reference current, accurate library documentation

❌ **DON'T:**
```yaml
- label: "Check React documentation"
  # No context7 validation = risk of outdated info
```

### Elicitation Balance
✅ **DO:**
```yaml
- id: validate_input
  type: elicit
  prompt: "What user problem does this solve?"
  validation:
    - check: user_problem_clear
      action: if_false → ask_clarifying_questions
  max_questions: 3
```

**Why:** Prevents infinite questioning loops while ensuring critical context

❌ **DON'T:**
```yaml
- type: elicit
  # No max_questions = risk of analysis paralysis
```

### File Path Validation
✅ **DO:**
```yaml
- id: gather_context
  items:
    - label: "File paths for changes"
      required: true
  validation:
    - verify_paths_exist: true
    - cross_reference: analysis_report.project_structure
```

**Why:** Prevents tasks from referencing non-existent locations

---

## Template Optimization Patterns

### Section Ownership
✅ **DO:**
```yaml
sections:
  - id: description
    title: What & Why
    owner: task-manager
    editors: [task-manager]
    elicit: true
```

**Why:** Clear ownership prevents cross-agent conflicts

### Context7 Requirements
✅ **DO:**
```yaml
- id: tech-stack
  title: Tech Stack & APIs
  context7_required: true
  instruction: |
    Use context7 MCP to validate and include usage patterns.
```

**Why:** Templates enforce context7 usage downstream

---

## Checklist Optimization Patterns

### Project-Specific Items
✅ **DO:**
```yaml
# For TypeScript projects (from analysis_report)
- [ ] Run `tsc --noEmit` to check types
- [ ] Verify no `@ts-ignore` comments added
```

**Why:** Checklists should reflect actual project tooling

❌ **DON'T:**
```yaml
# Generic item not relevant to project
- [ ] Run Python type checker  # Project is TypeScript!
```

### Workflow Alignment
✅ **DO:**
```yaml
# Reference core-config.xml workflow_stages
## Build Stage Checklist
- [ ] All tests pass
- [ ] Build completes without warnings
- [ ] No linting errors

## Validate Stage Checklist
- [ ] QA gate passed
- [ ] NFRs verified (per core-config.qa.nfr_defaults)
```

**Why:** Checklists map to defined workflow stages

---

## Context7 MCP Usage Guidelines

### When to Use Context7
1. **Validating library versions** in tech stack
2. **Fetching API patterns** for framework usage
3. **Checking deprecation status** of methods/patterns
4. **Including code examples** in task context sections

### Context7 Call Pattern
```yaml
- id: tech_validation
  type: context7_validation
  action:
    - extract_library_mentions
    - resolve_library_id_via_mcp
    - get_library_docs_via_mcp
    - cite_version_and_patterns
```

### Context7 Citation Format
```markdown
**Tech Stack Validation:**
- React: v18.2.0 (validated via context7: /facebook/react/v18.2.0)
  - Hooks pattern: [link to docs]
  - Recommended testing approach: React Testing Library
```

---

## Common Optimization Issues & Fixes

### Issue: Outdated Model References
```diff
- model: gemini-2.5-flash
+ model: gemini-2.5-pro
+ model_controls:
+   reasoning_effort: medium
+   verbosity: low
```

### Issue: Missing Context7 Validation
```diff
  - id: context-notes
    sections:
      - id: tech-stack
        instruction: "List frameworks and versions"
+       context7_required: true
+       validation: verify_with_context7_mcp
```

### Issue: Incorrect File Paths
```diff
- - "src/components/Button.tsx"  # Doesn't exist
+ - "src/infrastructure/components/Button.tsx"  # Verified from analysis_report
```

### Issue: Missing Rollback Notes
```diff
  - id: apply_change
    action:
      - edit_file
+     - store_rollback_notes
      - update_audit_log
```

---

## Optimization Workflow Checklist

### Before Starting Optimization
- [ ] analysis_report is populated
- [ ] Target artifact file exists
- [ ] Dependencies are verified
- [ ] User intent is clear

### During Optimization
- [ ] Proposed change links to analysis evidence
- [ ] Context7 validation performed (if tech refs)
- [ ] Impact assessment completed
- [ ] Numbered options presented to user
- [ ] User approval obtained before applying

### After Optimization
- [ ] Change applied correctly
- [ ] Audit log updated
- [ ] Progress table refreshed
- [ ] Rollback notes stored
- [ ] Next steps presented to user

---

## Anti-Patterns to Avoid

### ❌ Batch Processing
```yaml
# WRONG: Never do this
- id: optimize_all_agents
  action: iterate_and_apply_to_all
```

### ❌ Assuming Context
```yaml
# WRONG: Don't guess
context: "Assuming project uses REST API..."
```

### ❌ Skipping Validation
```yaml
# WRONG: Always verify
- tech_stack: "React 18.x"  # No context7 check
```

### ❌ Missing User Confirmation
```yaml
# WRONG: Never auto-apply without approval
- action: apply_all_pending_changes
```

---

## Optimization Metrics

Track these for each optimization session:

- **Artifacts Reviewed:** Count of agents/tasks/checklists analyzed
- **Changes Proposed:** Count of optimization suggestions
- **Changes Applied:** Count of user-approved modifications
- **Context7 Validations:** Count of tech stack verifications
- **Rollbacks Available:** Count of stored rollback notes
- **Time to Complete:** Estimate for user planning

---

## Gemini Token Optimization

### High-Impact Techniques
1. **Reuse analysis_report** — Don't re-read project files
2. **Persist reasoning context** — Leverage Responses API
3. **Structured templates** — Reduce verbose explanations
4. **Numbered options** — Clear, concise user choices
5. **Tool preambles** — Keep announcements brief

### Token Budget Guidelines
- **Analysis phase:** ~15-20k tokens (one-time)
- **Per artifact optimization:** ~3-5k tokens
- **Full optimize-all sequence:** ~50-70k tokens (10-15 artifacts)

### When to Refresh Context
- User explicitly requests re-analysis
- Major changes to project structure
- New dependencies added
- Analysis >1 week old

---

## Success Criteria

An optimization is successful when:

1. ✅ Change is **evidence-based** (links to analysis)
2. ✅ Tech references are **context7-validated**
3. ✅ File paths are **verified to exist**
4. ✅ User **approves before application**
5. ✅ **Rollback notes** stored
6. ✅ **Audit log** updated
7. ✅ **Progress tracked** transparently
8. ✅ Standards **aligned with project**

---

## Reference: Core Optimization Commands

| Command | Purpose | Key Task | Context7 |
|---------|---------|----------|----------|
| `*analyze-project` | Deep project analysis | analyze-project-context.yaml | Yes |
| `*optimize-agents` | Agent-by-agent optimization | optimize-agent.yaml | No |
| `*optimize-tasks` | Task-by-task optimization | optimize-task.yaml | Yes |
| `*optimize-checklists` | Checklist-by-checklist optimization | optimize-checklist.yaml | Yes |
| `*optimize-all` | Full sequence with stops | All above | Yes |

---

**Last Updated:** {{current_date}}
**Maintained by:** Prepper Agent
**Feedback:** Report issues via core-config escalation path
