# Getting Started with Codex

Welcome to Codex! This guide will walk you through setting up your AI agent team to help you with your project. Think of it as hiring and training a team of digital experts who are tailored to your specific needs.

## How to Get Started: Training Your AI Team

The goal of this setup process is to teach your AI agents about your project. You'll show them your code, your standards, and your way of working. This one-time setup makes the agents incredibly effective and efficient.

### Step 0: Place the `.codex` Directory in Your Project

Before you begin, you need to place the `.codex` directory (the one containing this guide) into the root folder of your own project.

- **If your project does not have a `.codex` directory:** Simply copy or move this entire `.codex` folder into your project's main directory.
- **If your project already has a `.codex` directory:** You will need to merge the contents. Copy all the files and folders from inside this `.codex` directory into your existing one. If any files have the same name, it is generally safe to overwrite them with the ones from this template.

### Step 1: Create a Project Snapshot

To understand your project, the AI needs to read it. The easiest way to do this is to combine all your relevant project files into a single text file. We call this "flattening" the project.

From your terminal, inside the `.codex` directory, run the following command:

```bash
# From inside the .codex directory
./utils/flatten-project.sh ../project_flatten.txt ../
```

- The first part (`../project_flatten.txt`) is the name of the output file that will be created.
- The second part (`../`) tells the script to look for your project in the parent directory.

This script is smart: it automatically ignores unnecessary files (like `node_modules`, `.git`, etc.) to create a clean, compact snapshot of your project for the AI to study.

### Step 2: Brief the Setup Specialist

Now you'll work with a special "Prepper" agent to configure the rest of your AI team. This is best done in a web-based AI chat platform that has a very large "context window" (like Gemini 1.5 Pro).

**Why use a platform like this?** A large context window is like having an AI with a massive short-term memory. It can "read" all of your project files at once. This is far more efficient and cost-effective than using models with smaller context windows, which would require breaking the files up into small, expensive chunks. It leads to a much better analysis and a better-trained team of agents.

1. **Start a new chat** on your chosen AI platform (e.g., Google AI Studio).

2. **Upload the necessary files.** For the Prepper agent to do its job, it needs its instructions and its tools. Upload the following files:
    - The agent's "brain": `.codex/agents/prepper.md`
    - The project snapshot you created: `project_flatten.txt`
    - Its task instructions:
        - `.codex/tasks/analyze-project-context.yaml`
        - `.codex/tasks/optimize-agent.yaml`
        - `.codex/tasks/optimize-task.yaml`
        - `.codex/tasks/optimize-checklist.yaml`
    - Its templates and knowledge:
        - `.codex/templates/project-analysis-tmpl.yaml`
        - `.codex/data/optimization-best-practices.md`

3. **Give the AI its first prompt.** Copy and paste the following into the chat:

> You are an AI agent. Your instructions are in the `prepper.md` file. All other files I've uploaded are your dependencies and knowledge base for my project. Your goal is to analyze my project and then guide me through optimizing the other agents, tasks, and checklists in the `.codex` directory to match my project's standards. Start by running your `*analyze-project` command.

### Step 3: Configure Your AI Team

The Prepper agent will now talk you through a step-by-step process to customize the AI team. It will:

1. **Analyze your project** using the snapshot file.
2. **Suggest improvements** for each agent and workflow, one by one.
3. **Show you a `diff`** of each proposed change. A `diff` is a simple "before and after" view, highlighting what's being removed (in red) and what's being added (in green). This makes it easy to see exactly what the agent wants to do.
4. **Ask for your approval** before making any changes.

This interactive process ensures that your AI team is perfectly aligned with your project's specific needs and coding styles.

### Step 4: Create the Agent Directory

Once your agents are configured, the final step is to "index" them. This creates a simple directory or "table of contents" so that the main CEO agent can easily find and delegate tasks to the right specialist.

To do this, you'll need to run a script that is capable of parsing the `.codex/utils/index-generator.xml` file. This will automatically scan the `.codex` directory and update the `AGENTS.md` file with a list of all available agents.

(If you're not sure how to do this, you may need to ask a technical colleague for a hand with this one-time step.)

## Recommended Tools

To make interacting with the Codex easier, we recommend installing the following command-line utility:

### Context7 MCP (`mcp`)

The `mcp` tool is a powerful utility that simplifies sending prompts with multiple file contexts directly to an AI model from your terminal. This is especially useful for invoking Codex agents, as it saves you from manually copying and pasting files into a web UI.

*You can find installation instructions here: [INSERT LINK TO context7 mcp INSTALLATION GUIDE]*

## How to Use the Codex

The Codex ecosystem is designed around a "CEO-Led" orchestration model. You don't talk to specialist agents directly. Instead, you start every request with the CEO agent, who then delegates the work.

### The Workflow

1. **Start with the CEO:** Always begin by invoking the CEO agent (`@.codex/agents/ceo.md`) with your high-level goal.

    ```bash
    @.codex/agents/ceo.md I need to add a new feature to allow users to export their data as a CSV.
    ```

2. **Follow the Guidance:** The CEO agent will analyze your request, determine the correct specialist for the job (e.g., the Product Manager), and instruct you on how to proceed.

    > *"Understood. For creating a new feature, you should start with the Product Manager. Please begin your next prompt with `@.codex/agents/pm.md` to create the specifications."*

3. **Invoke the Specialist:** Call the specialist agent as directed. The ecosystem is designed for this manual, conversational handoff, which ensures each agent has the minimal, most relevant context for its job.

    ```bash
    @.codex/agents/pm.md Let's create a spec for the CSV export feature.
    ```

This process is highly token-efficient and leads to better performance by giving each agent a focused persona and a clear, well-defined task.

### The Components

- **Agents (`.codex/agents/`):** These are the AI personas that perform the work (e.g., Developer, QA, PM).
- **Tasks (`.codex/tasks/`):** These are structured workflows that agents can execute (e.g., `create-task.yaml`).
- **Checklists (`.codex/checklists/`):** These are validation lists used by agents to ensure quality and completeness.
- **Templates (`.codex/templates/`):** These are boilerplate structures for documents like PRDs, tasks, and reports.
- **AGENTS.md:** Your go-to reference for a directory of all available agents and their roles.

By following this model, you can leverage a team of specialized AI agents to build, test, and manage your project with greater efficiency and quality.
