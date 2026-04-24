---
tags: [dashboard, adr, hell]
Created: $(date +%Y-%m-%d)
---

# Architecture Decision Records

```dataview
TABLE ADR_ID, ADR_Title, ADR_Status, ADR_Date
FROM #hell AND #adr
SORT ADR_Date DESC
```

## Pending Decisions

```dataview
TABLE Project, ADR_Title
FROM #hell AND #adr
WHERE ADR_Status = "PROPOSED"
```
