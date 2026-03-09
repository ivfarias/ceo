# AI-First Team Brain Template

This starter kit turns a repository into an operational memory system for a team that works with humans and AI agents in the same loop.

It is based on the structure used in `growth-tasks`, but everything here is generic on purpose. The goal is to give you a clean template you can adapt to your company, function, or project without carrying over team-specific data.

## What this gives you

- A permanent `context/` area for knowledge that should survive every cycle
- A `specs/` workspace for time-bound plans, execution, and retrospectives
- An `inbox/` landing zone for raw meeting notes, transcripts, and ad hoc observations
- Hidden AI directories (`.ai/`, `.codex/`, `.claude/`, `.github/`, `.gemini/`) that tell your agents where to live
- A default operating model for human ownership, AI autonomy, escalation, and document hygiene

## Core rule

If it expires, it belongs in `specs/`.
If it should still matter next cycle, it belongs in `context/`.

## Suggested setup

1. Copy this folder into a new repository.
2. Fill `context/how-we-operate.md`, `context/okrs.md`, and `context/icp.md` before asking AI to do strategic work.
3. Add one file per team member under `context/team/`.
4. Add one file per core channel, workflow, or function under `context/channels/`.
5. Copy or symlink the relevant agent configuration from this `ceo` repository into `.codex/`, `.claude/`, `.github/`, or `.gemini/`.
6. Start your first cycle by duplicating `specs/template/`.

## Directory map

```text
starter-kits/team-brain/
  context/                 # Cross-cycle memory
    channels/              # Channel, function, or workflow playbooks
    personas/              # Personas, jobs-to-be-done, research notes
    team/                  # One file per teammate
  inbox/                   # Raw notes waiting to be processed
    processed/             # Archived raw notes after distribution
  specs/                   # Time-bound cycles, projects, or sprints
    template/              # Canonical template for the next cycle
  .ai/                     # Shared AI assets across platforms
  .codex/                  # Codex-specific setup
  .claude/                 # Claude Code-specific setup
  .github/                 # Copilot/GitHub-specific setup
  .gemini/                 # Gemini-specific setup
```

## Recommended operating rhythm

- Put raw notes into `inbox/` daily.
- Process the inbox into structured docs at least once per day.
- Keep `context/` lean and durable.
- Keep cycle execution in `specs/<cycle>/`.
- Append learnings instead of rewriting history.

## How this pairs with `ceo`

This starter kit is the memory layer.

The rest of the `ceo` repository is the orchestration layer: agent profiles, tasks, checklists, and prompts. Use both together:

- `starter-kits/team-brain/` stores what your team knows
- `.codex/`, `.claude/`, `.github/`, and `.gemini/` in the root `ceo` repo define how your agents behave

If you want a team brain that is AI-first, you need both.
