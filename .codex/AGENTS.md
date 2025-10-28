
# Codex Agent Definitions

This file provides a high-level directory for all agents within the Codex ecosystem. It serves as a quick reference for understanding agent roles and how to invoke them.

<!-- BEGIN: CODEX-AGENTS -->
## Codex Orchestration (CEO-Led)

**Orchestrator**: Cleo (CEO agent) guides the user to the correct specialist agent based on their request.
**Mode**: Conversational handoff (stop-confirm-continue).
**Config**: `.codex/core-config.xml`

### How To Use

1. **Start with the CEO:** In your IDE, always begin by invoking the CEO agent with your high-level goal. This provides the orchestrator with the context it needs to guide you.

    ```bash
    @.codex/agents/ceo.md I need to build a new feature.
    ```

2. **Follow the Guidance:** The CEO agent will analyze your request and recommend the correct specialist for the job.
    > *"Understood. For building a new feature, you should start with the Product Manager. Please begin your next prompt with `@.codex/agents/pm.md` to create the specifications."*

3. **Invoke the Specialist:** Manually call the specialist agent as directed. The IDE will load this agent with its unique persona and skills, giving it focused context for the task.

    ```bash
    @.codex/agents/pm.md Let's create a spec for a new login page.
    ```

This manual, conversational handoff ensures that each agent has the minimal and most relevant context for its job, which is highly token-efficient and leads to better performance.

### Agent Directory

| Agent | ID | When To Use | Source File |
|---|---|---|---|
| Cleo (CEO) | `ceo` | Always start here. For routing tasks and orchestrating workflows. | `.codex/agents/ceo.md` |
| Manny (PM) | `pm` | For defining requirements, creating specs, and writing developer tasks. | `.codex/agents/pm.md` |
| Devon (Dev) | `developer` | For all coding, debugging, and implementation tasks. | `.codex/agents/developer.md` |
| Quinn (QA) | `qa` | For quality assurance, testing, and code reviews. | `.codex/agents/qa.md` |
| Mark (Marketing) | `marketer` | For marketing strategy, GTM plans, and campaign analysis. | `.codex/agents/marketer.md` |
| Ana (Analytics) | `analytics` | For data analysis, campaign performance reports, and metrics. | `.codex/agents/analytics.md` |
| Sally (UX) | `ux-expert` | For UI/UX design, frontend specifications, and wireframing. | `.codex/agents/ux-expert.md` |
| Pepe (Prepper) | `prepper` | For analyzing and optimizing the agent system itself. | `.codex/agents/prepper.md` |

<!-- END: CODEX-AGENTS -->
