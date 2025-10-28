# CEO-led Orchestration System

Welcome to the CEO-led Orchestration System, a framework for building, managing, and directing your own team of specialized AI agents. This system puts you in the driver's seat, acting as the CEO to orchestrate complex tasks and projects with AI assistance that is tailored *specifically* to your needs.

## Why Does This Exist?

Artificial intelligence has opened a door for anyone, especially **non-technical creators**, to bring their ideas to life. For the first time, you don't need to be a professional coder to build an application. However, anyone who has tried to build a project using AI alone (sometimes called "vibe coding") often runs into a wall. The process is plagued with common frustrations:

* **Inconsistent Outputs:** The AI's style and quality change from one prompt to the next.
* **Context Limitations:** The AI quickly forgets key details about your project, leading to bugs and nonsensical suggestions.
* **Lack of Structure:** A long chat history is a poor substitute for a structured project plan, making it impossible to manage complexity.
* **Degrading Quality:** Without a clear framework, the initial burst of progress quickly devolves into a messy, unmaintainable codebase.

This system was created specifically to solve these problems. It provides the structure and methodology that are missing from unstructured "AI coding." It establishes a clear, repeatable process that helps you maintain consistency and quality, turning the chaos of vibe coding into a focused, managed workflow.

While it's designed to empower non-technical users, it also serves as an excellent foundation for experienced developers who want to integrate AI into their workflow to handle the heavy lifting and accelerate their projects.

## What Does It Do?

This repository provides a structured set of templates for creating a team of AI agents with distinct roles and capabilities (e.g., Developer, Product Manager, QA, Marketer). The core of the system is the **CEO-led workflow**:

1. **You are the CEO:** You initiate every task with a high-level goal.
2. **You Delegate:** You *could* talk directly to specialist agents directly, but do it later, once you're familiar with the structure. At first, consult the main `CEO` agent, who helps you delegate the task to the correct specialist.
3. **Specialists Execute:** Each specialist agent has a focused persona and a clear set of tasks it can perform, ensuring high-quality, context-aware results.

This approach is highly efficient and gives you fine-grained control over the entire process, while still benefiting from the power of specialized AI assistants.

## How and When Should You Use It?

You should use this system when you want to go beyond simple one-shot prompts and bring structured AI assistance into your development or creative workflow. It's a template, not a plug-and-play product. Your first and most important job is to **train your team**.

Think of the initial setup as an investment. You will teach the agents about your project's specific technologies, coding conventions, and goals. Once they are trained, you will have a powerful, customized AI team that can help you:

* Brainstorm and spec out new features.
* Write, review, and refactor code.
* Generate documentation.
* Create marketing strategies.
* ...and much more.

You are the CEO. This is your company. Let's get your team ready for work.

## How to Get Started: Training Your AI Team

The goal of this setup process is to teach your AI agents about your project. You'll show them your code, your standards, and your way of working. This one-time setup makes the agents incredibly effective and efficient.

### Step 0: Place the `.codex` Directory in Your Project

Before you begin, you need to place the `.codex` directory (the one containing this guide) into the root folder of your own project.

* **If your project does not have a `.codex` directory:** Simply copy or move this entire `.codex` folder into your project's main directory.
* **If your project already has a `.codex` directory:** You will need to merge the contents. Copy all the files and folders from inside this `.codex` directory into your existing one. If any files have the same name, it is generally safe to overwrite them with the ones from this template.

### Step 1: Create a Project Snapshot

To understand your project, the AI needs to read it. The easiest way to do this is to combine all your relevant project files into a single text file. We call this "flattening" the project.

From your terminal, inside the `.codex` directory, run the following command:

```bash
# From inside the .codex directory
./utils/flatten-project.sh ../project_flatten.txt ../
```

* The first part (`../project_flatten.txt`) is the name of the output file that will be created.
* The second part (`../`) tells the script to look for your project in the parent directory.

This script is smart: it automatically ignores unnecessary files (like `node_modules`, `.git`, etc.) to create a clean, compact snapshot of your project for the AI to study.

### Step 2: Brief the Setup Specialist

Now you'll work with a special "Prepper" agent to configure the rest of your AI team. This is best done in a web-based AI chat platform that has a very large "context window" (like Gemini 1.5 Pro).

**Why use a platform like this?** A large context window is like having an AI with a massive short-term memory. It can "read" all of your project files at once. This is far more efficient and cost-effective than using models with smaller context windows, which would require breaking the files up into small, expensive chunks. It leads to a much better analysis and a better-trained team of agents.

1. **Start a new chat** on your chosen AI platform (e.g., Google AI Studio).

2. **Upload the necessary files.** For the Prepper agent to do its job, it needs its instructions and its tools. Upload the following files:
    * The agent's "brain": `.codex/agents/prepper.md`
    * The project snapshot you created: `project_flatten.txt`
    * Its task instructions:
        * `.codex/tasks/analyze-project-context.yaml`
        * `.codex/tasks/optimize-agent.yaml`
        * `.codex/tasks/optimize-task.yaml`
        * `.codex/tasks/optimize-checklist.yaml`
    * Its templates and knowledge:
        * `.codex/templates/project-analysis-tmpl.yaml`
        * `.codex/data/optimization-best-practices.md`

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

* **Agents (`.codex/agents/`):** These are the AI personas that perform the work (e.g., Developer, QA, PM).
* **Tasks (`.codex/tasks/`):** These are structured workflows that agents can execute (e.g., `create-task.yaml`).
* **Checklists (`.codex/checklists/`):** These are validation lists used by agents to ensure quality and completeness.
* **Templates (`.codex/templates/`):** These are boilerplate structures for documents like PRDs, tasks, and reports.
* **AGENTS.md:** Your go-to reference for a directory of all available agents and their roles.

By following this model, you can leverage a team of specialized AI agents to build, test, and manage your project with greater efficiency and quality.
