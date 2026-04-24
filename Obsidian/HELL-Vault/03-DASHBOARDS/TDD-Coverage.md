---
tags: [dashboard, tdd, hell]
Created: $(date +%Y-%m-%d)
---

# TDD Coverage Dashboard

```dataview
TABLE Module, Coverage, Tests_Total, Tests_Passing
FROM #hell AND #tdd
SORT Coverage ASC
```

## Low Coverage Areas

```dataview
TABLE Project, Module, Coverage
FROM #hell AND #tdd
WHERE Coverage < 80
SORT Coverage
```
