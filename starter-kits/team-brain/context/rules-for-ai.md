# Rules For AI

Every AI agent working in this repository should read this file before acting.

## Required reading order

1. `context/how-we-operate.md`
2. `context/okrs.md`
3. `context/icp.md`
4. `context/channels/`
5. `context/learnings.md`
6. `context/team/`
7. Active cycle `specs/<current-cycle>/command_center.md`

If the required context is missing or stale, stop and surface the gap instead of inventing certainty.

## Repository law

- If it expires, write it in `specs/`
- If it survives the cycle, write it in `context/`
- If it starts as raw notes, write it in `inbox/`
- If it is an artifact tied to execution, add the YAML header from `context/artifact-standard.md`

## How to process `inbox/`

Raw notes should be distributed into the right durable locations:

- Decisions -> `specs/<cycle>/decision_log.md`
- Status, blockers, and KPI updates -> `specs/<cycle>/command_center.md`
- Cross-cycle learnings -> `context/learnings.md`
- Channel or workflow learnings -> `context/channels/*.md`
- Team-specific observations -> `context/team/*.md`

After processing, move the raw file into `inbox/processed/` and record where its contents were distributed.

## What AI can do without asking

- Create drafts
- Process inbox notes
- Update dashboards and logs from explicit source material
- Add append-only learnings
- Create a new cycle folder from `specs/template/`

## What AI must not do without explicit approval

- Mark draft work as approved
- Change strategic priorities silently
- Invent metrics, decisions, or customer evidence
- Delete historical records because they look outdated
- Treat archived artifacts as active direction

## When to escalate

Escalate when:

- the source material is contradictory
- a KPI materially misses plan
- a blocker affects a core funnel or critical delivery
- the action changes scope, staffing, budget, or public communication
