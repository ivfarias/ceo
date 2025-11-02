# Agent Guidelines

This document defines shorthand terms and conventions used by AI agents in this project.

## ExecPlans

When writing **complex features** or **significant refactors**, use an **ExecPlan** (as described in `.agent/PLANS.md`) from design to implementation.

### What is an ExecPlan?

An ExecPlan (Execution Plan) is a comprehensive, living design document that guides multi-hour or multi-day implementation work. Unlike lean PRDs or simple task definitions, ExecPlans are:

- **Self-contained**: A complete novice can implement the feature from the ExecPlan alone
- **Living documents**: Updated continuously as work progresses
- **Outcome-focused**: Define success through observable, verifiable behavior
- **Progress-tracked**: Maintain checkboxes, timestamps, and completion status

### When to Use an ExecPlan

Use ExecPlans for:

- Complex features requiring 3+ hours of implementation
- Significant refactors touching multiple systems
- Features with unclear requirements that need validation
- Multi-step implementations spanning multiple sessions
- Work requiring extensive research or prototyping

Do NOT use ExecPlans for:

- Simple bug fixes
- Trivial feature additions
- One-file changes
- Clear, straightforward implementations

### When to Use Other Approaches

- **Lean PRD** (`.agent/templates/prd-tmpl.yaml`): Simple features, 1-2 page specs, clear requirements
- **Task YAML** (`.agent/tasks/*.yaml`): Procedural workflows, repeatable operations, checklists
- **Direct implementation**: Obvious bug fixes, minor changes, clear one-step tasks

### How to Create an ExecPlan

1. Use the template: `.agent/templates/execplan-tmpl.yaml`
2. Follow the requirements in: `.agent/PLANS.md`
3. Store active plans in: `plans/active/`
4. Archive completed plans in: `plans/completed/`

### Agent Responsibilities

**Developer Agent**: Creates and maintains ExecPlans during implementation. Updates Progress, Decision Log, and Surprises sections in real-time.

**PM Agent**: Determines when an ExecPlan is needed vs. a lean PRD. Collaborates on requirements and success criteria.

**CEO Agent**: Recommends ExecPlan workflow when analyzing complex user requests.

**QA Agent**: Reviews ExecPlans for testability and validates outcomes match acceptance criteria.

---

For complete ExecPlan guidelines and requirements, see `.agent/PLANS.md`.
