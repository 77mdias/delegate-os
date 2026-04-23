#!/bin/bash
#===========================================
# HELL-Obsidian Vault Creator
# Creates complete vault structure with
# templates, configs, and Dataview queries
#===========================================

set -e

VAULT_NAME="${1:-HELL-Vault}"
VAULT_PATH="${2:-.}"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}Creating HELL-Obsidian Vault: $VAULT_NAME${NC}"

# Create main structure
mkdir -p "$VAULT_PATH/$VAULT_NAME/00-INBOX"
mkdir -p "$VAULT_PATH/$VAULT_NAME/01-PROJECTS"
mkdir -p "$VAULT_PATH/$VAULT_NAME/02-PATTERNS/GRASP"
mkdir -p "$VAULT_PATH/$VAULT_NAME/02-PATTERNS/GoF"
mkdir -p "$VAULT_PATH/$VAULT_NAME/03-DASHBOARDS"
mkdir -p "$VAULT_PATH/$VAULT_NAME/04-TEMPLATES"
mkdir -p "$VAULT_PATH/$VAULT_NAME/05-ARCHIVE"
mkdir -p "$VAULT_PATH/$VAULT_NAME/.obsidian"

# Create template files

# Dashboard: Overview
cat > "$VAULT_PATH/$VAULT_NAME/03-DASHBOARDS/HELL-Overview.md" << 'TEMPLATE'
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
TEMPLATE

# Dashboard: Tech Debt
cat > "$VAULT_PATH/$VAULT_NAME/03-DASHBOARDS/Tech-Debt.md" << 'TEMPLATE'
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
TEMPLATE

# Dashboard: TDD Coverage
cat > "$VAULT_PATH/$VAULT_NAME/03-DASHBOARDS/TDD-Coverage.md" << 'TEMPLATE'
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
TEMPLATE

# Dashboard: ADRs
cat > "$VAULT_PATH/$VAULT_NAME/03-DASHBOARDS/ADR-Dashboard.md" << 'TEMPLATE'
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
TEMPLATE

# Template: Spec
cat > "$VAULT_PATH/$VAULT_NAME/04-TEMPLATES/SPEC-Template.md" << 'TEMPLATE'
---
Project: "[[PROJECT]]"
Module: ""
Type: spec
HELL_Phase: Requisitos
HELL_Gate: PENDING
Status: 🔥 ACTIVE
Patterns_GRASP: []
Patterns_GoF: []
Related: []
Coverage: 0
Tech_Debt: none
Created: $(date +%Y-%m-%d)
tags: [hell, spec]
---

# HELL Spec: [MODULE NAME]

## Overview
_Brief description of the module/specification._

## Requirements

### Functional
-

### Non-Functional
-

## Domain Model

```
[Entity-Relationship or Class Diagram]
```

## Acceptance Criteria

- [ ]

## Related Documents
- [[]]
TEMPLATE

# Template: TDD Log
cat > "$VAULT_PATH/$VAULT_NAME/04-TEMPLATES/TDD-Template.md" << 'TEMPLATE'
---
Project: "[[PROJECT]]"
Module: ""
Type: tdd
HELL_Phase: TDD
HELL_Gate: PENDING
Status: 🔥 ACTIVE
Patterns_GRASP: []
Patterns_GoF: []
Related: []
Coverage: 0
Tests_Total: 0
Tests_Passing: 0
Tech_Debt: none
Created: $(date +%Y-%m-%d)
tags: [hell, tdd]
---

# TDD Log: [MODULE]

## Test First

### 🔴 RED - Failing Test
```csharp
[Fail test code]
```

### 🟢 GREEN - Minimal Implementation
```csharp
[Pass test code]
```

### 🔵 REFACTOR
```csharp
[Refactored code]
```

## Coverage

| Metric | Value |
|--------|-------|
| Total Tests | 0 |
| Passing | 0 |
| Coverage | 0% |

## Debt Incurred

-
TEMPLATE

# Template: ADR
cat > "$VAULT_PATH/$VAULT_NAME/04-TEMPLATES/ADR-Template.md" << 'TEMPLATE'
---
Project: "[[PROJECT]]"
Module: ""
Type: decision
HELL_Phase: Architecture
HELL_Gate: PENDING
Status: 🔥 ACTIVE
ADR_ID: "ADR-001"
ADR_Title: ""
ADR_Status: PROPOSED
ADR_Date: $(date +%Y-%m-%d)
ADR_Context: ""
ADR_Decision: ""
ADR_Consequences: ""
Patterns_GRASP: []
Patterns_GoF: []
Related: []
Tech_Debt: none
Created: $(date +%Y-%m-%d)
tags: [hell, adr]
---

# ADR-[NUMBER]: [TITLE]

## Status
`PROPOSED | ACCEPTED | SUPERSEDED`

## Context
_What situation motivates this decision?_

## Decision
_What was decided?_

## Consequences
_What becomes easier/harder?_

## Alternatives Considered
-

## Related ADRs
- [[]]
TEMPLATE

# Template: Tech Debt
cat > "$VAULT_PATH/$VAULT_NAME/04-TEMPLATES/DEBT-Template.md" << 'TEMPLATE'
---
Project: "[[PROJECT]]"
Module: ""
Type: debt
HELL_Phase: Evolution
HELL_Gate: PENDING
Status: 🔥 ACTIVE
Debt_Items: []
Tech_Debt: major
Created: $(date +%Y-%m-%d)
tags: [hell, debt]
---

# Tech Debt: [PROJECT/SPRINT]

## Debt Items

| Item | Severity | Effort | Status |
|------|----------|--------|--------|
| | | | |

## Impact Analysis

## Remediation Plan

## Related Specs
- [[]]
TEMPLATE

# Template: Daily Note
cat > "$VAULT_PATH/$VAULT_NAME/04-TEMPLATES/DAILY-Template.md" << 'TEMPLATE'
---
Created: $(date +%Y-%m-%d)
tags: [daily, hell, session]
---

# Daily: $(date +%Y-%m-%d)

## Session Start
- Context:
- Goals:

## Tasks

- [ ]

## Notes


## Session End
- Completed:
- Blocked:
- Next:
TEMPLATE

# Template: Refactor
cat > "$VAULT_PATH/$VAULT_NAME/04-TEMPLATES/REFACTOR-Template.md" << 'TEMPLATE'
---
Project: "[[PROJECT]]"
Module: ""
Type: refactor
HELL_Phase: Refactor
HELL_Gate: PENDING
Status: 🔥 ACTIVE
Patterns_GRASP: []
Patterns_GoF: []
Related: []
Tech_Debt: none
Created: $(date +%Y-%m-%d)
tags: [hell, refactor]
---

# Refactor: [MODULE]

## Why Refactor?

## Target Code

## Smells Detected

## Refactoring Plan

1.
2.
3.

## After Refactor

### Code Quality
| Metric | Before | After |
|--------|--------|-------|
| Coupling | | |
| Cohesion | | |
| Complexity | | |

## Verification
- [ ] Tests still pass
- [ ] No new smells
- [ ] Performance maintained
TEMPLATE

# Obsidian config
cat > "$VAULT_PATH/$VAULT_NAME/.obsidian/.gitignore" << 'CONFIG'
# Ignore local settings
workspace
CONFIG

# Readme
cat > "$VAULT_PATH/$VAULT_NAME/README.md" << 'README'
# HELL-Obsidian Vault

Vault created by HELL Method + Obsidian integration.

## Structure

- `00-INBOX/` - Inbox for unprocessed notes
- `01-PROJECTS/` - Project-specific notes
- `02-PATTERNS/` - GRASP and GoF pattern catalog
- `03-DASHBOARDS/` - Dataview dashboards
- `04-TEMPLATES/` - Templater templates
- `05-ARCHIVE/` - Archived notes

## Required Plugins

- **Dataview** - For YAML queries
- **Templater** - For dynamic templates
- **Calendar** - For daily notes
- **QuickAdd** - Fast note creation

## Commands

```bash
# Create spec
obsidian create name="01-PROJECTS/MyApp/specs/hell-spec-auth" silent

# Create daily
obsidian daily:append content="- [ ] Task"

# Search
obsidian search query="tag:#hell #tdd" limit=20
```

## Links

- [HELL Method](kernel/hell/HELL-CORE-ENGINE.md)
- [Obsidian Integration](../docs/obsidian-integration.md)
README

echo -e "${GREEN}✓ Vault '$VAULT_NAME' created successfully!${NC}"
echo ""
echo "Next steps:"
echo "  1. Open vault in Obsidian"
echo "  2. Install plugins: Dataview, Templater, Calendar, QuickAdd"
echo "  3. Configure Templater to use templates from 04-TEMPLATES/"
echo "  4. Run: /dos-hell:obsidian-init validate"