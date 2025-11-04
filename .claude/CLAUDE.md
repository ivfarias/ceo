# CEO Orchestration System - Claude Code Instructions

**Note:** Copy this file to the project root (alongside README.md) for Claude Code to automatically incorporate these instructions.

## Project Overview

This is a multi-agent orchestration system for managing specialized AI agents. The system uses Claude Code's native subagent architecture with 8 specialized agents for different domains (development, product, QA, marketing, UX, analytics, optimization).

**Key Principle:** Each agent is a focused specialist. Route work to the right agent for best results.

## Agent Catalog

| Agent | ID | When to Use |
|-------|----|-----------|
| CEO | `ceo` | Need help deciding which agent to use |
| Developer | `developer` | Code implementation, architecture, debugging, testing |
| Product Manager | `pm` | Feature specs, requirements, product strategy |
| QA | `qa` | Quality gates, test coverage, NFR validation |
| Marketer | `marketer` | Go-to-market strategy, campaigns, growth |
| UX Expert | `ux-expert` | UI/UX design, wireframes, front-end specs |
| Analyst | `analyst` | Data analysis, metrics, campaign performance |
| Prepper | `prepper` | System optimization, agent tuning |

## Bash Commands & Aliases

### Testing

```bash
# Run all tests
npm test

# Run specific test suite
npm test -- tests/integration

# Run linter
npm run lint

# Type check
npm run type-check
```

### Development

```bash
# Start development server
npm run dev

# Build for production
npm run build

# Run in watch mode
npm run watch
```

### Agent Management

```bash
# Agents are in .claude/agents/
ls .claude/agents/

# Task procedures in .claude/tasks/
ls .claude/tasks/

# View agent configuration
cat .claude/agents/developer.md
```

## Code Style Guidelines

### General

- Use TypeScript with strict mode enabled
- Follow Prettier formatting (auto-format on save recommended)
- Write tests for all new features (TDD preferred)
- Keep functions small and focused (single responsibility)

### File Organization

- **Source code:** `src/` directory
- **Tests:** `tests/` directory (mirror `src/` structure)
- **Documentation:** `docs/` directory
- **ExecPlans:** `plans/active/` (working) or `plans/completed/` (archived)

### Naming Conventions

- **Files:** kebab-case (e.g., `user-service.ts`)
- **Classes:** PascalCase (e.g., `UserService`)
- **Functions/Variables:** camelCase (e.g., `getUserById`)
- **Constants:** UPPER_SNAKE_CASE (e.g., `MAX_RETRIES`)

### Testing Standards

- Unit tests for all public functions
- Integration tests for API endpoints
- Minimum 80% code coverage
- Test file naming: `*.test.ts` or `*.spec.ts`

## Repository Etiquette

### Never Modify

- Auto-generated index files (`*.index.yaml`)
- Configuration in `.claude/agents/` without approval

### Always Update

- Relevant documentation when changing features
- Test files when modifying code
- ExecPlan progress when working on complex features
- QA results section after reviews

### Commit Messages

Follow conventional commits format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`

Examples:

- `feat(auth): add OAuth2 login support`
- `fix(api): resolve timeout issue in user endpoint`
- `docs(readme): update installation instructions`

## Developer Environment

### Required

- Node.js 18+ (check: `node --version`)
- npm 9+ (check: `npm --version`)
- Git (check: `git --version`)

### Recommended

- VS Code with extensions:
  - TypeScript and JavaScript Language Features
  - Prettier - Code formatter
  - ESLint
- Claude Code

### Optional

- Docker (for containerized development)
- Postman or similar (API testing)

## Working with ExecPlans

### When to Create ExecPlan

Use for complex features (3+ hours, multi-system, significant unknowns):

```
1. Developer creates plan in plans/active/[feature-name]-execplan.md
2. Follow template at .claude/templates/execplan-tmpl.yaml
3. Update Progress, Decision Log, Surprises as you work
4. Move to plans/completed/ when done
```

### When to Skip ExecPlan

Use direct implementation for:

- Bug fixes
- One-file changes
- Clear, straightforward features
- Simple refactoring

## Quality Standards

### Before Committing

- [ ] Linter passes (no errors)
- [ ] Type checker passes (no errors)
- [ ] All tests pass
- [ ] Code coverage maintained or improved
- [ ] Documentation updated if needed

### Before Pull Request

- [ ] All commits follow message format
- [ ] Branch up to date with main
- [ ] Description explains what/why
- [ ] Tests cover new functionality
- [ ] No commented-out code

## Agent-Specific Guidance

### For Developer Agent

- Always run tests before marking complete
- Use parallel tool calls for file reads
- Follow ExecPlan workflow for complex features
- Reference: `.claude/checklists/code-quality-checklist.yaml`

### For PM Agent

- Validate assumptions before creating specs
- Challenge scope ("what's simplest?")
- Use PRD for simple features, ExecPlan for complex
- Reference: `.claude/checklists/pm-context-checklist.yaml`

### For QA Agent

- Evidence-based gate decisions only
- Use risk scoring matrix for prioritization
- Append results to `## QA Results` section only
- Reference: `.claude/checklists/code-quality-checklist.yaml`

## Troubleshooting

### Agent Not Found

Ensure agents are in `.claude/agents/` directory with proper YAML frontmatter.

### File Path Issues

- Use absolute paths or repo-relative paths
- Check if file exists before referencing
- Remember: `.agent/` is for the OpenAI model, `.claude/` is for the Claude model.

### Tool Permission Errors

Some operations require explicit user approval. Check Claude Code permissions settings.

## Project-Specific Notes

### Active System

The `.claude/` directory contains Claude Code optimized agents. This is the active system. Agents here use Claude 4.5 best practices with XML control tags.

### Dual Reference

Both systems can be referenced:

- Agent prompts reference `.claude/` files for templates and checklists
- Task procedures are in `.claude/tasks/` as YAML workflows
- Agent definitions are in `.claude/agents/` as markdown

---

**Quick Start:**

1. Read this file
2. Review agent catalog above
3. Choose appropriate agent for your task
4. Follow repository etiquette
5. Test your changes before committing

**Questions?**

- Review agent files in `.claude/agents/` for specific guidance
- See original README.md for system architecture
