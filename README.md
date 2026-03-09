![CEO-Led Orchestration System Logo](public/canva.png)

# CEO Agent Orchestration + Team Brain System

A streamlined framework for coordinating specialized AI agents across multiple AI platforms (GitHub Copilot CLI, OpenAI Codex CLI, Claude Code, and Gemini CLI) while also giving those agents a durable operating-memory repository. Inspired by BMAD-style agent orchestration, but adapted for **solo operators, small teams, and semi-technical builders** who need both lean agent workflows and a structured team brain.

This repository now includes two first-class pieces:

- agent orchestration assets in the root `.codex/`, `.claude/`, `.github/`, and `.gemini/` folders
- reusable repository starter kits in [`starter-kits/`](starter-kits/README.md), including the AI-first [`starter-kits/team-brain/`](starter-kits/team-brain/README.md)

**Why This Exists:**

The BMAD method is powerful but felt like overkill for many real projects. This system strips away the complexity while keeping the core benefits:

- **Token-efficient**: Dramatically reduced token usage vs. full BMAD implementations
- **Multi-model support**: Works with GitHub Copilot CLI (GPT-4/Claude), OpenAI Codex CLI (GPT-5-Codex), Claude Code (Claude Sonnet 4.5), and Gemini CLI (Gemini 2.5 Pro)
- **Model-optimized**: Each platform folder follows official prompting best practices for its AI model
- **Memory-aware**: Includes a durable team-brain repository pattern, not just agent prompts
- **Solo-friendly and team-usable**: Works for one person wearing many hats or a small AI-first team
- **Lean by default**: No heavy processes unless you actually need them

Think of it as building your own AI startup team with you as the CEO, plus the shared memory system that keeps that team aligned over time.

## Two Layers: Orchestration And Memory

This repository is now opinionated about two complementary layers:

- **Orchestration layer**: the root `.codex/`, `.claude/`, `.github/`, and `.gemini/` folders that define agents, tasks, prompts, and checklists
- **Memory layer**: [`starter-kits/`](starter-kits/README.md), starting with [`starter-kits/team-brain/`](starter-kits/team-brain/README.md), for persistent context, inbox processing, and cycle-based execution

If you only have orchestration, your agents stay smart for one session.
If you only have memory, your repository becomes organized but under-automated.
The strongest setup uses both.

## What Problem Does This Solve?

Working with AI for complex projects often leads to:

- **Inconsistent Outputs:** AI style and quality varies wildly between prompts
- **Context Loss:** AI forgets key project details, causing errors
- **No Structure:** Long chat histories are a poor substitute for organized workflows
- **Quality Degradation:** Initial progress quickly devolves into unmaintainable chaos

This system provides the structure missing from unstructured "AI coding." It combines repeatable agent workflows with a durable repository shape for context, decisions, learnings, and execution history.

## How It Works

This system has two connected parts.

### Part 1: Agent orchestration

The orchestration side uses **profile-based agent switching**:

1. **CEO Agent (Cleo)** - Workflow consultant that analyzes your request and prescribes complete workflows
2. **Specialist Agents** - Focused experts (Developer, PM, QA, etc.) that execute specific tasks
3. **Resource Indexes** - Auto-generated catalogs of available tasks, checklists, and data
4. **Profile Switching** - Native mechanism to switch between agent contexts for each model.

### The CEO Workflow

```text
User → CEO Agent → Analyzes intent → Consults indexes → Prescribes workflow

CEO Output:
├── Which agent(s) to use
├── What tasks to execute
├── What checklists to apply
└── What data to reference
```

The CEO doesn't execute work in the Codex profile workflow. It provides **complete, actionable guidance** so you know exactly what to do.

### Part 2: Team brain repository

The team-brain side gives those agents somewhere consistent to read from and write to:

- `context/` for durable knowledge
- `inbox/` for raw notes that need processing
- `specs/` for cycle-bound planning and execution
- hidden AI directories for shared and platform-specific agent assets

That repository shape lives in [`starter-kits/team-brain/`](starter-kits/team-brain/README.md).

## Quick Start

### 0. Start With The Right Repository Shape

If you want a durable repo where humans and AI share operating context, start from [`starter-kits/team-brain/`](starter-kits/team-brain/README.md). That gives you the memory layer first.

### 1. Choose Your AI Platform

Pick one (or more) AI coding assistants to install:

**GitHub Copilot CLI** (Recommended - uses GPT-4 or Claude 3.5):

```bash
npm install -g @github/copilot
```

**OpenAI Codex CLI** (GPT-5-Codex):

```bash
npm install -g codex-cli
```

**Claude Code** (Claude Sonnet 4.5):

```bash
npm i @anthropic-ai/claude-code
```

**Gemini CLI** (Gemini 2.5 Pro):

```bash
npm install -g @google/gemini-cli
```

### 2. Set Up Agent Profiles

Each platform has its own configuration folder with 7 core agents (+ Prepper for system optimization). Choose the folder for your platform:

- **`.github/`** → GitHub Copilot CLI (requires git commit/push to activate)
- **`.agent/`** → OpenAI Codex CLI
- **`.claude/`** → Claude Code
- **`.gemini/`** → Gemini CLI

**Note:** The `prepper` agent is for system optimization only - see [Prepper Guide](docs/PREPPER-GUIDE.md). Use it separately via web AI, not in regular workflows.

**Configuration steps vary by platform:**

#### GitHub Copilot CLI

Agents work automatically via custom agents in `.github/agents/` - no manual config needed. Just ensure your repo is pushed to GitHub.

To access CEO agent:

```bash
# Start Copilot CLI
copilot

# Then type the slash command
/agent ceo
```

#### OpenAI Codex CLI / Claude Code / Gemini CLI

Add profiles to your config file:

```bash
# For Codex (check actual install location)
cat .agent/profiles.toml >> ~/.agent/config.toml

# For Claude (check actual install location)
cat .claude/profiles.toml >> ~/.claude/config.toml

# For Gemini (check actual install location)
# Gemini uses a `settings.json` file. Profiles from `.gemini/profiles.toml` must be manually added.
# See .gemini/SETUP.md for details.
```

Then access CEO agent:

```bash
# Codex
codex --profile ceo

# Claude
claude --profile ceo

# Gemini
gemini --profile ceo
```

See platform-specific SETUP.md files for detailed instructions:

- `.github/SETUP.md`
- `.agent/SETUP.md`
- `.claude/SETUP.md`
- `.gemini/SETUP.md`

### 3. Connect Orchestration To Memory

Point your agents at the repository that uses the team-brain shape. In practice that means your prompts, tasks, and docs should read and write against:

- `context/` for durable context
- `specs/<cycle>/` for active work
- `inbox/` for raw notes

### 4. Start with the CEO

The CEO agent analyzes your request and prescribes which specialist agents to use.

**Example conversation:**

```
You: "I need to build a login feature"

CEO: "This is a new feature development workflow.

Step 1: Product Manager (pm agent)
- Define requirements and create PRD
- Command: codex --profile pm  (or your platform equivalent)

Step 2: Developer (developer agent)
- Implement based on PRD
- Command: codex --profile developer

Step 3: QA (qa agent)
- Validate implementation
- Command: codex --profile qa"
```

### 5. Follow the Prescribed Workflow

Execute each step the CEO recommends:

```bash
# Step 1 - PM creates spec
codex --profile pm
> "Create PRD for login feature"

# Step 2 - Developer implements
codex --profile developer
> "Implement login feature per PRD in docs/"

# Step 3 - QA validates
codex --profile qa
> "Review login implementation"
```

Replace `codex` with `copilot`, `claude`, or `gemini` depending on your platform.

## System Components

### Starter Kits (`starter-kits/`)

Repository scaffolds that give your agents a durable place to operate:

- [`team-brain`](starter-kits/team-brain/README.md) - Persistent context, inbox processing, cycle templates, and AI platform folders

### Core Agents (`.github/agents/`)

Specialized AI personas for your orchestration workflow:

- **ceo** (Cleo) - Workflow consultant, routes to specialists
- **developer** (Devon) - Architecture, implementation, debugging
- **pm** (Manny) - Product strategy, specs, task creation
- **qa** (Quinn) - Testing, quality assurance, validation
- **analytics** (Ana) - Data analysis, metrics, reporting
- **marketer** (Mark) - Marketing strategy, campaigns, growth
- **ux-expert** (Sally) - UI/UX design, wireframes

### Meta Agent (Separate Tool)

- **prepper** (Pepe) - System optimizer (NOT for regular workflows)
  - **Purpose:** Tune and optimize the orchestration and memory system for a real project
  - **When:** Initial setup, tech stack changes, periodic optimization
  - **How:** Use via web AI (ChatGPT, Claude, Gemini) with flattened codebase
  - **⚠️ High token usage** - See [Prepper Guide](docs/PREPPER-GUIDE.md) for details

**Note:** Prepper is a meta-optimization tool, not part of daily development. Use standard agents (CEO → Developer → QA) for regular work.

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

### What CEO Can Do (All Platforms)

✅ Analyze intent accurately
✅ Consult indexes for available resources
✅ Prescribe complete, actionable workflows
✅ Provide exact copy-paste commands
✅ Sequence multi-step workflows properly
✅ Guide through complex scenarios

### Platform-Specific Capabilities

#### GitHub Copilot CLI

✅ **Can invoke other agents automatically** via custom agent tools
✅ CEO can directly call Developer, PM, QA, etc. without manual switching
✅ Seamless multi-agent workflows in single conversation

#### Claude Code

✅ **Can invoke other agents via MCP** (Model Context Protocol)
✅ Supports tool-based agent invocation when MCP server configured
⚠️ Requires MCP setup (optional, advanced feature)

#### Codex CLI

❌ **Cannot invoke agents automatically**
⚠️ Manual profile switching required (`codex --profile <name>`)
⚠️ CEO prescribes workflow, user executes each step

#### Gemini CLI

✅ **Can invoke other agents via MCP** (Model Context Protocol)
✅ Supports tool-based agent invocation when MCP server configured
⚠️ Requires MCP setup (optional, advanced feature)

### What CEO Cannot Do (Any Platform)

❌ Execute arbitrary code outside of agent context
❌ Transform into other agents mid-conversation (changes context)
❌ Modify system files directly
❌ Auto-apply changes without user confirmation

## Common Workflows

### New Feature Development

**GitHub Copilot CLI:**

```bash
copilot
/agent ceo
> "I want to add user notifications feature"
# CEO prescribes: PM → Developer → QA
```

**Codex/Claude/Gemini:**

```bash
codex --profile ceo "I want to add user notifications feature"
# CEO prescribes: PM → Developer → QA
# Then: codex --profile pm, codex --profile developer, etc.
```

### Bug Fix

**GitHub Copilot CLI:**

```bash
copilot
/agent ceo
> "Fix bug in authentication module"
```

**Codex/Claude/Gemini:**

```bash
codex --profile ceo "Fix bug in authentication module"
# CEO prescribes: Developer → QA
```

### Requirements/Planning

**GitHub Copilot CLI:**

```bash
copilot
/agent pm
> "Create spec for dashboard feature"
```

**Codex/Claude/Gemini:**

```bash
codex --profile pm "Create spec for dashboard feature"
# Direct PM access (skip CEO for simple planning)
```

### Marketing Campaign

**GitHub Copilot CLI:**

```bash
copilot
/agent ceo
> "Plan campaign for product launch"
```

**Codex/Claude/Gemini:**

```bash
codex --profile ceo "Plan campaign for product launch"
# CEO prescribes: Marketer → Analytics
```

### Direct Agent Access

Once familiar with the system, bypass CEO and go directly to specialists:

**GitHub Copilot CLI:**

```bash
copilot
/agent developer  # Implementation
/agent qa         # Code review
/agent pm         # Product specs
/agent analytics  # Data analysis
```

**Codex/Claude/Gemini:**

```bash
codex --profile developer "Implement authentication"
codex --profile qa "Review recent changes"
codex --profile pm "Create PRD for user dashboard"
codex --profile analytics "Analyze user engagement metrics"
```

## Agent Orchestration Approaches

This system supports different orchestration models depending on your platform:

### GitHub Copilot CLI - Native Agent Orchestration

- ✅ Uses native custom agents in `.github/agents/`
- ✅ Activated automatically from Git repo
- ✅ Accessed via `/agent <name>` slash commands
- ✅ No manual profile configuration needed
- ✅ **CEO can invoke other agents automatically** via tool calls
- ⚠️ Requires repo to be pushed to GitHub

**Workflow:** CEO analyzes → Automatically calls Developer → Developer calls QA → Complete

### Claude Code - MCP-Based Orchestration (Optional)

- ✅ Uses TOML profile configuration
- ✅ Activated via `--profile <name>` flag
- ✅ Works offline without Git
- ✅ **Can auto-invoke agents with MCP setup** (advanced)
- ⚠️ Requires one-time profile setup
- ⚠️ MCP server setup optional for auto-invocation

**Workflow Options:**

- **With MCP:** CEO analyzes → Calls agents automatically
- **Without MCP:** CEO prescribes → User switches profiles manually

### Codex CLI / Gemini CLI - Manual Orchestration

- ✅ Uses TOML profile configuration
- ✅ Activated via `--profile <name>` flag
- ✅ Works offline without Git
- ❌ **Cannot auto-invoke agents** - manual switching required
- ⚠️ Requires one-time profile setup

**Workflow:** CEO prescribes → User runs `codex --profile developer` → User runs `codex --profile qa`

### Common Trade-offs (All Platforms)

- Context doesn't automatically transfer between agents (file-based artifacts bridge this)
- User maintains awareness of workflow state

### How We Handle Context Transfer

- CEO provides complete guidance with exact commands
- Agents coordinate via file-based artifacts (PRDs, specs, reports, etc.)
- Users maintain context by following prescribed workflows
- Each platform folder (`.github/`, `.agent/`, etc.) is self-contained

## Customization

### Quick Manual Tweaks

1. **Update `technical-preferences.yaml`** with your tech stack
2. **Customize agent instructions** in `.github/agents/*.md` (or your platform folder)
3. **Add project-specific tasks** in `.github/tasks/`
4. **Define custom checklists** in `.github/checklists/`
5. **Regenerate indexes** with `.github/utils/generate-indexes.sh`

### AI-Powered Optimization with Prepper

**For comprehensive system optimization**, use the Prepper agent:

**⚠️ Use via Web AI, not CLI** - Prepper consumes significant tokens analyzing your entire project.

**What Prepper does:**

- Analyzes your project's tech stack, workflow, and repository shape
- Optimizes agent configurations to match your needs
- Tunes task workflows and checklists
- Aligns the orchestration layer and team-brain patterns with your actual workflow

**Quick Start:**

1. Flatten your codebase: `npx llm-context` (creates `context.md`)
2. Open web AI (Claude.ai, ChatGPT, or Gemini)
3. Load Prepper agent from `.github/agents/prepper.md`
4. Upload flattened codebase
5. Request: "Optimize this agent system and team-brain setup for my project"
6. Apply recommendations manually
7. Regenerate indexes

**📖 Full Guide:** [Prepper Guide](docs/PREPPER-GUIDE.md) - Detailed instructions, flattening options, best practices

**When to use Prepper:**

- ✅ Initial project setup
- ✅ Tech stack migrations
- ✅ Periodic optimization (every 3-6 months)
- ❌ NOT for daily development (use CEO → Developer → QA)

### Extend the System

The framework is designed to be extended:

- **New agent roles:** Create new `.md` files with YAML frontmatter
- **Custom workflows:** Define new `.yaml` tasks
- **Domain knowledge:** Add `.yaml` or `.md` files to `data/`
- **Quality gates:** Create new checklists

Everything is file-based and version-controlled.

## Architecture Philosophy

This system is inspired by BMAD-METHOD's orchestration patterns but **radically simplified** for solo builders and small teams:

### What We Kept from BMAD

- **Agent specialization:** Different roles for different tasks
- **Structured workflows:** Repeatable processes via tasks and checklists
- **Knowledge bases:** Centralized data and templates
- **Persistent context:** A repository shape for storing what the team learns

### What We Simplified

- **No heavy orchestration layer:** CEO prescribes workflows instead of executing them
- **Multi-model support:** Optimized configurations for GPT-5-Codex, Claude Sonnet 4.5, Gemini 2.5 Pro, and GitHub Copilot
- **No enterprise ceremony:** Lightweight PRDs and optional ExecPlans instead of mandatory bureaucracy
- **Massive token reduction:** File-based coordination and bash-generated indexes (not LLM calls)

### Core Design Principles

- **File-based coordination:** Agents communicate through artifacts (PRDs, reports, etc.)
- **Index-driven discovery:** CEO knows available resources via auto-generated catalogs
- **Profile-based isolation:** Each agent operates in its own context
- **Workflow prescription:** CEO provides complete guidance, not just routing
- **Zero-token maintenance:** Indexes generated via bash, not LLM calls
- **Lean by default:** Simple workflows for simple tasks, complexity only when needed
- **Repository as memory:** Important context lives in files, not just in chat history

## Troubleshooting

### CEO doesn't know about new resource

**Solution:** Regenerate indexes for your platform

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

### Profile not found (Codex/Claude/Gemini)

**Solution:** Add profiles to your config

```bash
# Codex
cat .agent/profiles.toml >> ~/.agent/config.toml

# Claude
cat .claude/profiles.toml >> ~/.claude/config.toml

# Gemini
cat .gemini/profiles.toml >> ~/.gemini/config.toml
```

### GitHub Copilot CLI agents not appearing

**Solution:** Ensure your repository is pushed to GitHub

```bash
git add .
git commit -m "Add CEO orchestration agents"
git push origin main
```

GitHub Copilot CLI reads custom agents from `.github/agents/` only when the repo is on GitHub.

### Agent gives generic responses

**Solution:**

- **GitHub Copilot CLI:** Agents auto-load from `.github/agents/*.md` - check file syntax
- **Others:** Verify profile config points to correct agent file paths
- Ensure YAML frontmatter in agent files is valid

### Indexes out of date

**Solution:** The git pre-commit hook should auto-update. If not:

```bash
# Make scripts executable (any platform)
chmod +x .git/hooks/pre-commit

# Make platform-specific index generator executable
chmod +x .github/utils/generate-indexes.sh  # GitHub Copilot
chmod +x .agent/utils/generate-indexes.sh   # Codex
chmod +x .claude/utils/generate-indexes.sh  # Claude
chmod +x .gemini/utils/generate-indexes.sh  # Gemini
```

## Platform Comparison

| Feature               | GitHub Copilot CLI    | Codex CLI              | Claude Code              | Gemini CLI               |
|-----------------------|-----------------------|------------------------|--------------------------|--------------------------|
| **AI Model**          | GPT-4 / Claude 3.5    | GPT-5-Codex            | Claude Sonnet 4.5        | Gemini 2.5 Pro           |
| **Setup**             | Auto (via `.github/`) | Manual profiles        | Manual profiles          | Manual profiles          |
| **Activation**        | `/agent <name>`       | `--profile <name>`     | `--profile <name>`       | `--profile <name>`       |
| **Auto-Invoke Agents**| ✅ Yes (native)       | ❌ No                  | ⚠️ Yes (with MCP)        | ⚠️ Yes (with MCP)        |
| **Orchestration**     | Automatic             | Manual switching       | Manual/MCP hybrid        | Manual/MCP hybrid        |
| **Git Required**      | Yes (push to GH)      | No                     | No                       | No                       |
| **Config File**       | None needed           | `~/.agent/config.toml` | `~/.claude/settings.json`| `~/.gemini/settings.json`|
| **Best For**          | Seamless workflows    | OpenAI power users     | Flexibility              | Google ecosystem         |

**Legend:**

- ✅ Fully supported
- ⚠️ Supported with additional setup
- ❌ Not supported
- ❓ Uncertain/untested

Choose based on your existing workflow and model preference. All platforms provide the same 7 core agents (CEO, Developer, PM, QA, Analytics, Marketer, UX-Expert) plus Prepper for optimization.

## Contributing

When adding new agents or resources:

1. Follow existing file patterns (YAML frontmatter for agents, structured tasks)
2. Run `generate-indexes.sh` to update catalogs
3. Test with CEO to ensure proper routing
4. Document any new workflow patterns

## License

This is a template framework. Customize freely for your projects and operating systems.

---

**You are the CEO. This is your agent system and your team brain.**
