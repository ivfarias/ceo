# Artifact Header Standard

Every file in `specs/<cycle>/artifacts/` should begin with this YAML header:

```yaml
---
type: proposal        # proposal | deliverable | analysis | data | discussion
status: draft         # draft | approved | implemented | archived
owner: Name
cycle: 001
next_action: ""
---
```

## Rules

1. If an artifact is missing a header, add one.
2. If you are unsure, use `status: draft`.
3. Archived artifacts are useful for history, not active guidance.
4. Data artifacts can support metrics, but they do not replace strategic judgment.
