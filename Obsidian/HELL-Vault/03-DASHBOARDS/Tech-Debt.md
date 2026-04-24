---
tags: [dashboard, debt, hell]
Created: $(date +%Y-%m-%d)
---

# Tech Debt Dashboard

```dataview
TABLE Debt_Items.severity AS Severidade, Debt_Items.effort AS Esforço, Project
FROM #hell AND #debt
WHERE Status = "🔥 ACTIVE"
SORT Debt_Items.severity DESC
```

## Debt by Project

```dataview
TABLE Project, length(file.etags) as Items
FROM #hell AND #debt
GROUP BY Project
```
