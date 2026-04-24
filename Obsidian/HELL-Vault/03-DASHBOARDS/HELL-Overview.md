---
tags: [dashboard, hell]
Created: $(date +%Y-%m-%d)
---

# HELL Overview Dashboard

```dataview
TABLE HELL_Phase, HELL_Gate, Patterns_GoF
FROM #hell
WHERE Status = "🔥 ACTIVE"
SORT Updated DESC
```

## Active Phases

```dataview
TABLE Project, Module, HELL_Phase
FROM #hell
WHERE HELL_Gate != "PASSED"
SORT HELL_Phase
```

## Recent Updates

```dataview
TABLE file.ctime as Created, Status
FROM #hell
SORT file.ctime DESC
LIMIT 10
```
