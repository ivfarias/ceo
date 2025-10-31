# CEO Orchestration System - Setup Guide

## Quick Start

### 1. Install Codex CLI

```bash
npm install -g codex-cli
```

### 2. Add Agent Profiles

Copy the contents of `.agent/profiles.toml` into your `~/.agent/config.toml`:

```bash
cat .agent/profiles.toml >> ~/.agent/config.toml
```

Or manually copy-paste the profiles section from `.agent/profiles.toml` into your config.

### 3. Start Using Agents

```bash
# Start with the CEO orchestrator
codex --profile ceo

# Or start directly with a specialist agent
codex --profile developer
codex --profile pm
codex --profile qa
```

## Agent Profiles

This system includes the following agent profiles:

- **ceo**: Executive orchestrator that routes work to specialists
- **developer**: Senior developer for implementation, debugging, and architecture
- **pm**: Product manager for strategy, specs, and task creation
- **qa**: QA specialist for testing and quality assurance
- **analytics**: Data analyst for metrics and reporting
- **marketer**: Marketing strategist for growth and campaigns
- **ux-expert**: UX/UI designer for interface design
- **prepper**: System optimizer for agent configuration

## How It Works

### Manual Agent Switching (Simple)

1. Start with CEO:
   ```bash
   codex --profile ceo
   ```

2. CEO analyzes your request and recommends an agent:
   ```
   You: "I need to implement a login feature"
   CEO: "This requires the developer agent. Exit and run: codex --profile developer"
   ```

3. Switch to the recommended agent:
   ```bash
   codex --profile developer
   ```

### Direct Agent Access

If you know which agent you need, skip the CEO and go directly:

```bash
codex --profile developer "Implement user authentication"
```

## Advanced: MCP Sub-Agents (Optional)

For automatic orchestration where the CEO can invoke agents directly, see:
- `.agent/docs/MCP_SETUP.md` (coming soon)

This requires installing an MCP server and is optional for power users.

## Regenerating Indexes

If you add new agents, tasks, or checklists, regenerate the indexes:

```bash
.agent/utils/generate-indexes.sh
```

This updates:
- `agents.index.yaml`
- `tasks.index.yaml`
- `checklists.index.yaml`
- `templates.index.yaml`
- `data.index.yaml`
- `profiles.toml`

## Project Structure

```
.agent/
├── agents/           # Agent definitions
├── tasks/            # Task templates
├── checklists/       # Quality checklists
├── templates/        # Document templates
├── data/             # Shared knowledge
├── utils/            # Utility scripts
├── profiles.toml     # Generated profile configs
├── *.index.yaml      # Generated indexes
└── SETUP.md          # This file
```

## Need Help?

- Check agent documentation: `.agent/agents/*.md`
- View available tasks: `.agent/tasks.index.yaml`
- See README.md for system overview
