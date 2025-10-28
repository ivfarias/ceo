# Getting Started with Codex

This guide provides the necessary steps to set up and use the Codex agent ecosystem for your project.

## How to Get Started

Follow these steps to configure the Codex for your specific project needs. The goal is to adapt the generic agent templates and tasks to your project's unique context, conventions, and technology stack.

### Step 1: Flatten Your Project

The first step is to create a single-file representation of your project's codebase. This "flattened" file will be used as context for the setup agent.

Run the `flatten-project.sh` script from within the `.codex` directory, pointing it to your project's root:

```bash
# From inside the .codex directory
./utils/flatten-project.sh ../project_flatten.txt ../
```

- The first argument (`../project_flatten.txt`) is the output file.
- The second argument (`../`) is the root directory of your project to flatten.

This script intelligently excludes unnecessary files (like `node_modules`, `.git`, etc.) and creates a compact text file that the AI can easily consume.

### Step 2: Prepare the Setup Agent

You will use a specialized "Prepper" agent to analyze your project and configure the Codex. This is best done using a powerful AI model (like GPT-4, Claude 3, or Gemini 1.5) in a chat interface that allows file uploads.

1.  **Start a new chat** with your chosen AI model.
2.  **Upload the `prepper.md` agent file:** Provide the AI with the contents of `.codex/agents/prepper.md`. This file contains the core instructions for the setup agent.
3.  **Upload your flattened project file:** Upload the `project_flatten.txt` file you created in Step 1.

Your initial prompt should look something like this:

> You are an AI agent. Your instructions are in the `prepper.md` file. Your knowledge base for my project is the `project_flatten.txt` file. Your goal is to analyze my project and then guide me through optimizing the other agents, tasks, and checklists in the `.codex` directory to match my project's standards. Start by running your `*analyze-project` command.

### Step 3: Configure the Codex

The Prepper agent will now guide you through a `stop-confirm-continue` workflow to optimize the Codex artifacts. It will:

1.  **Analyze the project context** from the flattened file.
2.  **Propose changes** to agents, tasks, and checklists one by one.
3.  **Present a `diff`** of each proposed change and ask for your approval.

This process ensures that the agents' instructions, dependencies, and tasks are tailored to your project's specific libraries, coding conventions, and file structure.

### Step 4: Index the Codex

After configuring the artifacts, you need to update the central indexes so the system can find and use them.

You will need a CLI agent or a script that can parse the `.codex/utils/index-generator.xml` specification and execute its instructions. This process will:

1.  Scan the `.codex` directory for all agents, tasks, checklists, and templates.
2.  Generate or update the `*.index.yaml` files (e.g., `agents.index.yaml`).
3.  Update the main `AGENTS.md` file with the latest agent directory.

This step is crucial for the CEO orchestrator agent to discover and delegate tasks to the correct specialists.

## How to Use the Codex

The Codex ecosystem is designed around a "CEO-Led" orchestration model. You don't talk to specialist agents directly. Instead, you start every request with the CEO agent, who then delegates the work.

### The Workflow

1.  **Start with the CEO:** Always begin by invoking the CEO agent (`@.codex/agents/ceo.md`) with your high-level goal.

    ```
    @.codex/agents/ceo.md I need to add a new feature to allow users to export their data as a CSV.
    ```

2.  **Follow the Guidance:** The CEO agent will analyze your request, determine the correct specialist for the job (e.g., the Product Manager), and instruct you on how to proceed.

    > *"Understood. For creating a new feature, you should start with the Product Manager. Please begin your next prompt with `@.codex/agents/pm.md` to create the specifications."*

3.  **Invoke the Specialist:** Call the specialist agent as directed. The ecosystem is designed for this manual, conversational handoff, which ensures each agent has the minimal, most relevant context for its job.

    ```
    @.codex/agents/pm.md Let's create a spec for the CSV export feature.
    ```

This process is highly token-efficient and leads to better performance by giving each agent a focused persona and a clear, well-defined task.

### The Components

-   **Agents (`.codex/agents/`):** These are the AI personas that perform the work (e.g., Developer, QA, PM).
-   **Tasks (`.codex/tasks/`):** These are structured workflows that agents can execute (e.g., `create-task.yaml`).
-   **Checklists (`.codex/checklists/`):** These are validation lists used by agents to ensure quality and completeness.
-   **Templates (`.codex/templates/`):** These are boilerplate structures for documents like PRDs, tasks, and reports.
-   **AGENTS.md:** Your go-to reference for a directory of all available agents and their roles.

By following this model, you can leverage a team of specialized AI agents to build, test, and manage your project with greater efficiency and quality.
