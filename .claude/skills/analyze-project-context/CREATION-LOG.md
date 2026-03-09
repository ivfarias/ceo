# Analyze Project Context - Update to Universal Project Analysis

## Context

Updated the analyze-project-context skill from tech-focused (code projects only) to universal (works with any project type: technical, content, documentation, or mixed).

## Update Date

2026-01-16

## Previous Version

**Focus:** Technical projects only (required `.codex/core-config.xml` and `package.json`)

**Limitations:**
- Would STOP with critical error if `.codex/core-config.xml` missing
- Assumed all projects have package managers
- Tech stack analysis required for all projects
- No support for content, documentation, or non-technical projects

## Updated Version

**Focus:** Universal project analysis (technical, content, documentation, mixed)

**Key Changes:**
1. **Removed hard dependencies** on `.codex/core-config.xml` and `package.json`
2. **Added project type detection** (Technical, Content, Documentation, Mixed)
3. **Made tech analysis conditional** (only for technical projects)
4. **Added AGENTS.md creation** (project-specific AI agent best practices)
5. **Integrated constitution.md** (invokes speckit-constitution skill)
6. **Generalized discovery patterns** (works for any file structure)

## Design Decisions

### 1. Project Type Detection

**Decision:** Classify projects into 4 types (Technical, Content, Documentation, Mixed)

**Rationale:**
- Different project types need different analysis approaches
- Technical projects need dependency analysis, content projects need content patterns
- Mixed projects need both
- Clear classification guides appropriate analysis depth

### 2. Conditional Tech Analysis

**Decision:** Only run tech stack analysis if technical indicators found

**Rationale:**
- Content projects don't have package managers or dependencies
- Forcing tech analysis on non-tech projects causes failures
- Skip what doesn't apply, focus on what exists

### 3. AGENTS.md Creation

**Decision:** Always create `.claude/AGENTS.md` with project-specific best practices

**Rationale:**
- AI agents need project-specific guidance, not generic advice
- Discovered patterns should be documented for future use
- Captures "unwritten rules" that aren't in README
- Benefits ALL project types (code, content, docs)

**Format:**
- Project overview (from README)
- File organization patterns (discovered from structure)
- Naming conventions (inferred from existing files)
- Common tasks (how to work with this project)
- Quality standards (what to check)
- Anti-patterns (what NOT to do)
- Technology notes (if technical project)

### 4. Constitution Integration

**Decision:** Invoke `speckit-constitution` skill to create/update `.specify/memory/constitution.md`

**Rationale:**
- All projects benefit from documented principles
- Constitution captures non-negotiable standards
- Speckit-constitution skill already exists and handles interactive creation
- Better to trigger existing skill than duplicate logic

**Flow:**
- If constitution doesn't exist → invoke speckit-constitution with suggestions from analysis
- If constitution exists → validate project follows it, report violations

### 5. Evidence-Based Discovery

**Decision:** Sample actual files to infer conventions (don't assume)

**Rationale:**
- Projects rarely document all their conventions
- File naming, structure, and patterns reveal "unwritten rules"
- Sampling 3-5 representative files provides sufficient evidence
- More reliable than assumptions or guessing

## Workflow Changes

### Before (Technical Only)

```
1. Check .codex/core-config.xml (CRITICAL - STOP if missing)
2. Read package.json for tech stack
3. Validate dependencies with context7
4. Extract standards from config files
5. Check .codex/ agents and tasks
6. Report gaps and mismatches
```

### After (Universal)

```
1. Detect project type (Technical/Content/Documentation/Mixed)
2. Discover structure (works for any organization)
3. Infer patterns from existing files (universal approach)
4. Find existing standards docs
5. [Conditional] Tech analysis if technical project
6. Create AGENTS.md (project-specific best practices)
7. Invoke speckit-constitution (create/update constitution)
8. Synthesis report with recommendations
```

## Testing Approach (TDD)

### RED Phase - Failing Test

**Test Case:** Non-technical project (marketing campaign with docs, no code)

**Structure:**
```
/tmp/test-nontechnical-project/
├── README.md
├── docs/
│   └── strategy.md
├── guides/
└── templates/
```

**Expected Failure (Old Skill):**
- CRITICAL ERROR: `.codex/core-config.xml` missing
- Would STOP immediately without analyzing

### GREEN Phase - Updated Skill

**Changes Made:**
1. Removed `.codex/core-config.xml` check
2. Added project type detection
3. Made tech analysis conditional
4. Added AGENTS.md creation
5. Added constitution integration
6. Generalized pattern discovery

**Expected Success:**
- Detects as "Content" project
- Discovers docs/ and guides/ organization
- Infers content patterns
- Creates AGENTS.md with content best practices
- Triggers constitution creation
- Reports successfully

### REFACTOR Phase - Edge Cases

**Additional Tests Needed:**
- [ ] Empty project (minimal files)
- [ ] Technical project (ensure still works well)
- [ ] Documentation project (sphinx, mkdocs, etc.)
- [ ] Mixed project (code + extensive docs)
- [ ] Project with existing AGENTS.md (update vs overwrite)
- [ ] Project with existing constitution (validation)

## Benefits

### Universal Applicability
- Works with ANY organized file structure
- No longer restricted to code projects
- Supports content creators, technical writers, mixed teams

### Better Documentation
- AGENTS.md captures project-specific patterns
- Constitution documents principles
- Future AI agents have clear guidance

### Reduced Assumptions
- Discovers what exists rather than assuming structure
- Samples actual files to infer patterns
- Reports evidence-based findings

### Skill Integration
- Leverages existing speckit-constitution skill
- Suggests relevant skills for next steps
- Part of larger workflow (analyze → constitution → speckit)

## Migration Notes

### Backward Compatibility

**For existing technical projects:**
- Skill still works (detects as Technical, runs appropriate analysis)
- All tech-specific checks preserved (when applicable)
- AGENTS.md is new (additive, doesn't break anything)
- Constitution integration is new (additive)

**For projects expecting .codex/ structure:**
- .codex/ checks removed (were non-standard, specific to one workflow)
- AGENTS.md replaces .codex/ agent guidance
- Constitution replaces .codex/ config constraints

### Breaking Changes

**Removed:**
- `.codex/core-config.xml` requirement (was stopping non-tech projects)
- `context7` validation requirement (too specific, optional now)
- `.codex/` artifact mapping (too specific to one workflow)

**Why Removed:**
- `.codex/` is not a universal standard
- Blocking on specific files prevents universal use
- Generic analysis should work anywhere

## Common Rationalizations

| Excuse | Reality |
|--------|---------|
| "Content projects don't need analysis" | They need pattern discovery and best practices docs |
| "AGENTS.md is redundant with README" | README explains project, AGENTS.md explains how to work with it |
| "Constitution is overkill for small projects" | Even small projects benefit from documented principles |
| "Tech projects need special handling" | They get it (conditional tech analysis) |
| "Removing .codex checks breaks existing workflows" | .codex was non-standard, AGENTS.md + constitution replace it |

## Success Indicators

Updated skill is working when:
- ✅ Works on technical projects (Node, Python, etc.)
- ✅ Works on content projects (markdown, templates, etc.)
- ✅ Works on documentation projects (docs repos)
- ✅ Works on mixed projects (code + extensive docs)
- ✅ Creates AGENTS.md with project-specific patterns
- ✅ Triggers constitution creation/update
- ✅ No critical errors on non-technical projects
- ✅ Reports evidence-based findings

## Next Steps

### Testing Validation
- [ ] Test with technical project (Node.js, Python, etc.)
- [ ] Test with content project (marketing, docs)
- [ ] Test with documentation project (mkdocs, sphinx)
- [ ] Test with mixed project (code + docs)
- [ ] Verify AGENTS.md contains useful project-specific info
- [ ] Verify constitution gets created appropriately

### Documentation Updates
- [ ] Update any references to analyze-project-context
- [ ] Add examples for different project types
- [ ] Document AGENTS.md format and contents
- [ ] Link to speckit-constitution skill

## References

- Writing Skills: `.claude/skills/writing-skills/SKILL.md`
- Speckit Constitution: `.claude/skills/speckit-constitution/SKILL.md`
- Original Skill: `.claude/skills/analyze-project-context/SKILL.md` (updated)
