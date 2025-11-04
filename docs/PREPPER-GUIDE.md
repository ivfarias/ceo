# Prepper Agent - Meta-Optimization Guide

> **⚠️ Important:** The Prepper agent is NOT part of the standard orchestration workflow. It's a **meta-optimization tool** used to tune and optimize the orchestration system itself.

## What is Prepper?

Prepper (Pepe) is a system optimization specialist that:
- Analyzes your project structure and tech stack
- Tunes agent configurations to match your project needs
- Optimizes task definitions and checklists
- Ensures the orchestration system aligns with your actual workflow

**Think of it as:** A consultant that customizes the CEO orchestration system to perfectly fit your project.

## Why Use Web AI Instead of CLI?

**⚠️ RECOMMENDATION: Use Prepper via web interfaces (ChatGPT, Claude Web, Gemini Web) instead of CLI tools.**

### Reasons:

1. **High Token Consumption** - Prepper analyzes entire project structures, requiring 10-100x more tokens than regular agents
2. **Extended Context** - Web interfaces handle large contexts better with longer conversation persistence
3. **Visual Review** - Easier to review analysis reports and optimization recommendations in browser
4. **Cost Control** - Web interfaces often have subscription pricing vs. per-token CLI costs
5. **Iteration Friendly** - Multiple rounds of optimization work better in persistent web sessions

### When to Use CLI:

Only use CLI if:
- You need to automate Prepper workflows in scripts
- Your project is very small (< 50 files)
- You want integration with local development tools

## How to Use Prepper

### Step 1: Flatten Your Codebase

Prepper needs to analyze your entire project. Use code flattening to create a single-file snapshot:

#### Option A: Using `llm-context` (Recommended)

```bash
# Install llm-context
npm install -g llm-context

# Flatten your project
llm-context

# This creates a context.md file with your entire codebase
```

#### Option B: Using `tree` and `cat`

```bash
# Create directory structure
tree -I 'node_modules|.git|dist|build' > project-structure.txt

# Concatenate important files
find . -type f \
  -not -path "*/node_modules/*" \
  -not -path "*/.git/*" \
  -not -path "*/dist/*" \
  -not -path "*/build/*" \
  \( -name "*.js" -o -name "*.ts" -o -name "*.jsx" -o -name "*.tsx" -o -name "*.md" -o -name "*.yaml" -o -name "*.json" \) \
  -exec sh -c 'echo "=== {} ===" && cat {}' \; > codebase-flat.txt
```

#### Option C: Using GitHub Copilot CLI `gh-context`

```bash
# If you have GitHub CLI with copilot extension
gh copilot context > gh-context.txt
```

#### Option D: Using `repomix`

```bash
# Install repomix
npm install -g repomix

# Generate flattened output
repomix --output repomix-output.txt
```

### Step 2: Open Web AI Interface

Choose your preferred AI platform:

**ChatGPT** (GPT-4): https://chat.openai.com
```
Use GPT-4 (not GPT-4o) for better analysis quality
```

**Claude** (Sonnet 4.5): https://claude.ai
```
Recommended - Best for detailed system analysis
```

**Gemini** (2.5 Pro): https://gemini.google.com
```
Good for large codebases due to extended context window
```

### Step 3: Load Prepper Agent

Copy-paste the Prepper agent definition from your platform folder:

**For Claude/ChatGPT/Gemini:**
```
1. Open the web interface
2. Create new chat
3. Paste contents of .github/agents/prepper.md (or .agent/, .claude/, .gemini/)
4. Send message: "Confirm you've loaded the Prepper agent role"
```

### Step 4: Upload Flattened Codebase

```
Attach or paste the flattened codebase file from Step 1:
- context.md (llm-context)
- codebase-flat.txt (manual)
- gh-context.txt (GitHub CLI)
- repomix-output.txt (repomix)
```

### Step 5: Request Analysis

```
"Analyze this project and optimize the CEO orchestration system 
(agents, tasks, checklists) to align with this project's tech stack, 
patterns, and workflows."
```

### Step 6: Review & Apply Recommendations

Prepper will provide:
1. **Project Analysis Report** - Tech stack, patterns, conventions
2. **Optimization Recommendations** - Specific changes to agents/tasks/checklists
3. **Priority Order** - What to change first
4. **Impact Assessment** - Risk and benefit analysis

Apply changes manually by editing files in:
- `.github/agents/` (or your platform folder)
- `.github/tasks/`
- `.github/checklists/`
- `.github/data/`

### Step 7: Regenerate Indexes

After applying changes:

```bash
# GitHub Copilot CLI
.github/utils/generate-indexes.sh

# Codex CLI
.agent/utils/generate-indexes.sh

# Claude Code
.claude/utils/generate-indexes.sh

# Gemini CLI
.gemini/utils/generate-indexes.sh
```

## Common Optimization Scenarios

### New Project Setup

```
"I'm starting a new [React/Vue/Django/etc] project. 
Optimize the orchestration system for this tech stack."
```

**Prepper will:**
- Configure Developer agent with framework-specific tools
- Add tech-specific checklists (e.g., React best practices)
- Update data files with framework conventions
- Tune task workflows for your stack

### Migrating Tech Stacks

```
"We're migrating from [Old Stack] to [New Stack]. 
Update agents to support both during transition."
```

**Prepper will:**
- Add migration-specific tasks
- Update Developer agent with dual-stack knowledge
- Create migration checklists
- Add compatibility checks

### Team Workflow Alignment

```
"Our team uses [specific workflow/tools]. 
Align the system with our actual practices."
```

**Prepper will:**
- Analyze current workflow patterns
- Adjust task sequences to match
- Add team-specific quality gates
- Update agent instructions for tools you use

### Performance Optimization

```
"The agents are too verbose / not detailed enough. 
Optimize for [speed/quality/balance]."
```

**Prepper will:**
- Adjust verbosity settings
- Tune reasoning effort levels
- Optimize task granularity
- Balance token usage vs. output quality

## What Prepper Can Optimize

### ✅ Agent Configurations
- Role definitions and capabilities
- Tool access and permissions
- Verbosity and reasoning effort
- Model-specific optimizations
- Dependencies and resource references

### ✅ Task Workflows
- Step sequences and ordering
- Validation checkpoints
- Input/output specifications
- Conditional logic
- Error handling

### ✅ Checklists
- Quality gate criteria
- Tech-stack specific checks
- Priority ordering
- Pass/fail thresholds

### ✅ Data Files
- Tech stack preferences
- Code style guides
- Architecture patterns
- Team conventions

## What Prepper Cannot Do

### ❌ Execute Code
Prepper only analyzes and recommends. You must manually apply changes.

### ❌ Auto-Deploy
Changes don't auto-apply. Review, edit files, regenerate indexes manually.

### ❌ Replace Domain Expertise
Prepper optimizes the system, but you still need domain knowledge for your project.

### ❌ Ongoing Monitoring
Prepper is a one-time or periodic optimization, not continuous monitoring.

## Prepper vs. Other Agents

| Feature | Prepper | CEO | Developer | PM |
|---------|---------|-----|-----------|-----|
| **Purpose** | System optimization | Workflow routing | Code implementation | Product specs |
| **When to Use** | Setup / major changes | Every workflow | Code tasks | Planning |
| **Frequency** | Once / periodic | Always | Often | As needed |
| **Token Usage** | Very High (1000s) | Low (100s) | Medium (500s) | Medium (500s) |
| **Platform** | Web AI (recommended) | CLI or Web | CLI or Web | CLI or Web |

## Best Practices

### ✅ DO:
- Use web AI for Prepper sessions
- Flatten codebase before analysis
- Review recommendations before applying
- Test changes incrementally
- Regenerate indexes after changes
- Document why you made each change

### ❌ DON'T:
- Run Prepper in CLI for large projects
- Auto-apply all recommendations blindly
- Skip the flattening step (poor analysis)
- Make all changes at once (risky)
- Forget to regenerate indexes
- Use Prepper for regular development tasks

## Example Prepper Session

```markdown
# In Claude Web (claude.ai)

## Message 1: Load Agent
[Paste .github/agents/prepper.md content]

## Message 2: Upload Context
[Attach context.md from llm-context]

## Message 3: Request Analysis
"Analyze this Next.js project and optimize the CEO orchestration 
system. Focus on:
1. TypeScript/Next.js specific tooling
2. Vercel deployment workflow
3. Tailwind CSS conventions
4. Our preference for functional components"

## Prepper Response:
[Detailed analysis report with optimization recommendations]

## Message 4: Prioritize
"Show me the top 3 changes to make first"

## Prepper Response:
1. Update Developer agent with Next.js App Router patterns
2. Add TypeScript strict mode checklist
3. Configure Tailwind config validation task

## Message 5: Get Details
"Show me the exact edits for recommendation #1"

## Prepper Response:
[Detailed diff for .github/agents/developer.md]

## Apply manually → Regenerate indexes → Test
```

## Troubleshooting

### "Prepper's analysis is too generic"

**Solution:** Provide more context about your project:
- Team size and experience level
- Specific tools and versions
- Unique workflow requirements
- Pain points with current setup

### "Too many recommendations to implement"

**Solution:** Ask Prepper to prioritize:
```
"Of these 15 recommendations, which 3 have the highest 
ROI and lowest risk? Start with those."
```

### "Changes broke the system"

**Solution:** Rollback via git:
```bash
git checkout HEAD -- .github/agents/
git checkout HEAD -- .github/tasks/
# Regenerate indexes
.github/utils/generate-indexes.sh
```

### "Prepper wants to rewrite everything"

**Solution:** Set constraints:
```
"Only optimize existing patterns. Do not suggest 
architectural changes or rewrites."
```

## When to Run Prepper

### Initial Setup ✅
When first adding CEO orchestration to your project

### Tech Stack Changes ✅
When migrating frameworks or adding major dependencies

### Team Growth ✅
When team size or composition changes significantly

### Workflow Changes ✅
When adopting new development practices or tools

### Periodic Tuning ✅
Every 3-6 months for mature projects

### Every Feature ❌
Too expensive - use regular agents for features

### Daily Development ❌
Prepper is not for routine work

## Summary

**Prepper = System tuner, not feature builder**

- Use **web AI** (ChatGPT/Claude/Gemini) to save tokens
- **Flatten your codebase** first for accurate analysis
- Apply changes **manually** and **incrementally**
- **Regenerate indexes** after any modifications
- Run Prepper **periodically**, not constantly

For day-to-day development, use the standard agents (CEO, Developer, PM, QA, etc.) via CLI or web as needed.

---

**Next Steps:**
1. Choose web AI platform (Claude recommended)
2. Flatten your codebase with llm-context
3. Follow Step-by-Step guide above
4. Apply recommended optimizations
5. Return to normal workflow with optimized system
