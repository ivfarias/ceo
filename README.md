# CEO-Led Orchestration System

A streamlined framework for coordinating specialized AI agents using GitHub Copilot CLI. Inspired by BMAD-style agent orchestration but designed specifically for **solo entrepreneurs** and **semi-tech people** who need a much more streamlined and lean way to orchestrate multiple agents.

**Why This Exists:**

The BMAD method is powerful but, I personally couldn't really get the whole benefit of it, because it felt like an  overkill for professionals like me, running things on their own. This system strips away the complexity while keeping the core orchestration benefits:

- **Token-efficient**: Dramatically reduced token usage vs. full BMAD implementations
- **Claude Sonnet 4.5**: Optimized for Claude with official prompting best practices
- **Solo-friendly**: Built for one person wearing many hats, not enterprise teams
- **Lean by default**: No heavy processes unless you actually need them

Think of it as building your own AI startup team with you as the CEO that routes work to the right specialists—without the enterprise overhead.

## What Problem Does This Solve?

Working with AI for complex projects often leads to:

- **Inconsistent Outputs:** AI style and quality varies wildly between prompts
- **Context Loss:** AI forgets key project details, causing errors
- **No Structure:** Long chat histories are a poor substitute for organized workflows
- **Quality Degradation:** Initial progress quickly devolves into unmaintainable chaos

This system provides the structure and methodology missing from unstructured "AI coding." It establishes clear, repeatable workflows with specialized agents, turning chaos into focused productivity.

## How It Works

This system uses **profile-based agent switching** with GitHub Copilot CLI:

1. **CEO Agent (Cleo)** - Workflow consultant that analyzes your request and prescribes complete workflows
2. **Specialist Agents** - Focused experts (Developer, PM, QA, etc.) that execute specific tasks
3. **Resource Indexes** - Auto-generated catalogs of available tasks, checklists, and data
4. **Profile Switching** - Native GitHub Copilot CLI mechanism to switch between agent contexts

### The CEO Workflow

```bash
User → CEO Agent → Analyzes intent → Consults indexes → Prescribes workflow

CEO Output:
├── Which agent(s) to use
├── What tasks to execute
├── What checklists to apply
└── What data to reference
```

The CEO doesn't execute work—it provides **complete, actionable guidance** so you know exactly what to do.

## Quick Start

### 1. Install GitHub Copilot CLI

```bash
npm install -g @github/copilot
```

### 2. Add Agent Profiles

Copy the generated profile configurations to your GitHub Copilot config:

```bash
cat .github/profiles.toml >> ~/.github/config.toml
```

This adds all agent profiles (`ceo`, `developer`, `pm`, `qa`, `analytics`, `marketer`, `ux-expert`, `prepper`) to your GitHub Copilot CLI.

### 3. Start with the CEO

```bash
copilot --profile ceo
```

Then tell the CEO what you need:

```bash
"I need to build a login feature"
```

The CEO will analyze your request and prescribe a complete workflow:

```bash
**New Feature Development Workflow**

**Step 1: Product Manager (Manny)**
Command: `copilot --profile pm`
Task: Execute task create-doc with prd-tmpl template
Checklist: pm-context-checklist
Reference: technical-preferences.yaml
Expected Output: PRD document

**Step 2: Developer (Devon)**
Command: `copilot --profile developer`
Task: Implement feature based on PRD
Checklist: code-quality-checklist, openai-sdk-compliance-checklist
Reference: technical-preferences.yaml
Expected Output: Working implementation with tests

**Step 3: QA (Quinn)**
Command: `copilot --profile qa`
Task: review-task
Checklist: Test coverage validation
Expected Output: QA report

---
Quick Start:
copilot --profile pm
```

### 4. Follow the Prescribed Workflow

```bash
copilot --profile pm
```

Then: "Execute task create-doc with prd-tmpl template for login feature"

The specialist agent will execute with full context from its definition file.

## System Components

### Agents (`.github/agents/`)

Specialized AI personas with distinct capabilities:

- **ceo** (Cleo) - Workflow consultant, routes to specialists
- **developer** (Devon) - Architecture, implementation, debugging
- **pm** (Manny) - Product strategy, specs, task creation
- **qa** (Quinn) - Testing, quality assurance, validation
- **analytics** (Ana) - Data analysis, metrics, reporting
- **marketer** (Mark) - Marketing strategy, campaigns, growth
- **ux-expert** (Sally) - UI/UX design, wireframes
- **prepper** (Pepe) - System optimization, agent tuning

### Tasks (`.github/tasks/`)

Structured, executable workflows:

- `create-doc` - Generate documents from templates
- `create-task` - Define developer-ready tasks
- `review-task` - QA validation workflow
- `analyze-campaign-performance` - Marketing analytics
- `document-project` - Auto-generate project docs
- ...and more

### Checklists (`.github/checklists/`)

Quality validation lists:

- `code-quality-checklist` - Code standards validation
- `pm-context-checklist` - Requirements completeness
- `analytics-checklist` - Data analysis validation
- `openai-sdk-compliance-checklist` - SDK best practices

### Templates (`.github/templates/`)

Document boilerplates:

- `prd-tmpl` - Product Requirements Document
- `architecture-tmpl` - System architecture
- `task-tmpl` - Task specification
- `analytics-report-tmpl` - Analytics reports

### Data (`.github/data/`)

Knowledge base and references:

- `technical-preferences.yaml` - Tech stack and standards
- `marketing-frameworks.yaml` - Marketing strategies
- `optimization-best-practices.md` - System optimization

### Indexes (`.github/*.index.yaml`)

Auto-generated resource catalogs:

- `agents.index.yaml` - All available agents
- `tasks.index.yaml` - All available tasks
- `checklists.index.yaml` - All validation checklists
- `templates.index.yaml` - All document templates
- `data.index.yaml` - All knowledge resources

These are used by the CEO agent to provide informed workflow recommendations.

## Maintenance

### Regenerating Indexes

Indexes are auto-regenerated by a git pre-commit hook. To manually regenerate:

```bash
.github/utils/generate-indexes.sh
```

This updates:

- All `*.index.yaml` files
- `profiles.toml` (for user setup)
- `SETUP.md` (user documentation)

**Important:** These files are auto-generated. Don't edit them manually—edit the source files (agents, tasks, etc.) and regenerate.

### Adding New Resources

1. **New Agent:** Create `.github/agents/new-agent.md` following existing patterns
2. **New Task:** Create `.github/tasks/new-task.yaml` with workflow definition
3. **New Checklist:** Create `.github/checklists/new-checklist.yaml`
4. **Regenerate:** Run `.github/utils/generate-indexes.sh` (or just commit—hook runs it)

The CEO will automatically know about new resources after regeneration.

## How the CEO Works

The CEO agent is a **Workflow Consultant**, not a simple router.

### What CEO Does

1. **Loads indexes** on activation (knows all available resources)
2. **Analyzes** user request using keyword matching
3. **Consults indexes** to verify resources exist
4. **Prescribes** complete workflows with:
   - Exact agent profile commands
   - Specific task names
   - Relevant checklists
   - Reference data files
5. **Sequences** multi-agent workflows when needed

### What CEO Cannot Do

❌ Invoke agents automatically (GitHub Copilot CLI doesn't support this)
❌ Execute code or create files
❌ Transform into other agents mid-conversation
❌ Run multi-agent workflows automatically

### What CEO Can Do

✅ Analyze intent accurately
✅ Consult indexes for available resources
✅ Prescribe complete, actionable workflows
✅ Provide exact copy-paste commands
✅ Sequence multi-step workflows properly
✅ Guide through complex scenarios

## Common Workflows

### New Feature Development

```bash
copilot --profile ceo "I want to add [feature]"
```

CEO prescribes: **PM → Developer → QA**

### Bug Fix

```bash
copilot --profile ceo "Fix bug in [component]"
```

CEO prescribes: **Developer → QA**

### Requirements/Planning

```bash
copilot --profile ceo "Create spec for [feature]"
```

CEO prescribes: **PM** (single agent)

### Marketing Campaign

```bash
copilot --profile ceo "Plan campaign for [product]"
```

CEO prescribes: **Marketer → Analytics**

### Direct Agent Access

Once familiar with the system, bypass CEO and go directly to specialists:

```bash
copilot --profile developer "Implement authentication"
copilot --profile qa "Review recent changes"
copilot --profile pm "Create PRD for user dashboard"
```

## Why Profile-Based Switching?

This system uses GitHub Copilot CLI's native profile mechanism instead of mid-conversation agent transformation:

**Advantages:**

- ✅ Native GitHub Copilot CLI feature (no extra setup)
- ✅ Each agent gets full context from its definition file
- ✅ Clean separation between agent contexts
- ✅ No MCP server required
- ✅ Simple for users to understand

**Trade-off:**

- Manual profile switching (can't auto-invoke)
- Context doesn't automatically transfer between agents

**Solution:**

- CEO provides complete guidance with exact commands
- Agents coordinate via file-based artifacts (specs, reports, etc.)
- Users maintain context by following prescribed workflows

## Customization

### Adapt to Your Project

1. **Update `technical-preferences.yaml`** with your tech stack
2. **Customize agent instructions** in `.github/agents/*.md`
3. **Add project-specific tasks** in `.github/tasks/`
4. **Define custom checklists** in `.github/checklists/`
5. **Regenerate indexes** with `.github/utils/generate-indexes.sh`

### Extend the System

The framework is designed to be extended:

- **New agent roles:** Create new `.md` files with YAML frontmatter
- **Custom workflows:** Define new `.yaml` tasks
- **Domain knowledge:** Add `.yaml` or `.md` files to `data/`
- **Quality gates:** Create new checklists

Everything is file-based and version-controlled.

## Architecture Philosophy

This system is inspired by BMAD-METHOD's orchestration patterns but **radically simplified** for solo entrepreneurs:

### What We Kept from BMAD

- **Agent specialization:** Different roles for different tasks
- **Structured workflows:** Repeatable processes via tasks and checklists
- **Knowledge bases:** Centralized data and templates

### What We Simplified

- **No heavy orchestration layer:** CEO prescribes workflows instead of executing them
- **Optimized for Claude Sonnet 4.5:** Single model with official prompting best practices
- **No enterprise ceremony:** Lightweight PRDs and optional ExecPlans instead of mandatory bureaucracy
- **Massive token reduction:** File-based coordination and bash-generated indexes (not LLM calls)

### Core Design Principles

- **File-based coordination:** Agents communicate through artifacts (PRDs, reports, etc.)
- **Index-driven discovery:** CEO knows available resources via auto-generated catalogs
- **Profile-based isolation:** Each agent operates in its own context
- **Workflow prescription:** CEO provides complete guidance, not just routing
- **Zero-token maintenance:** Indexes generated via bash, not LLM calls
- **Lean by default:** Simple workflows for simple tasks, complexity only when needed

## Troubleshooting

### CEO doesn't know about new resource

**Solution:** Regenerate indexes

```bash
.github/utils/generate-indexes.sh
```

### Profile not found

**Solution:** Add profiles to your config

```bash
cat .github/profiles.toml >> ~/.github/config.toml
```

### Agent gives generic responses

**Solution:** Ensure agent loads its full definition file on activation. Check that `dependencies` in YAML point to correct resources.

### Indexes out of date

**Solution:** The git pre-commit hook should auto-update. If not:

```bash
chmod +x .git/hooks/pre-commit
chmod +x .github/utils/generate-indexes.sh
```

## Contributing

When adding new agents or resources:

1. Follow existing file patterns (YAML frontmatter for agents, structured tasks)
2. Run `generate-indexes.sh` to update catalogs
3. Test with CEO to ensure proper routing
4. Document any new workflow patterns

## License

This is a template framework. Customize freely for your projects.

---

**You are the CEO. This is your AI company. Let's build something amazing.**
