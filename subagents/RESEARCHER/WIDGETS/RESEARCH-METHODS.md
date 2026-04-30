# Research Methods Guide

> Systematic approach to technology research for the RESEARCHER agent.

## 1. TECHNOLOGY EVALUATION FRAMEWORK

```
┌─────────────────────────────────────────────────────────────┐
│                 TECHNOLOGY EVALUATION MATRIX                  │
├─────────────────┬───────────────┬───────────────┬────────────┤
│    CRITERIA     │  Library A    │  Library B    │  Library C │
├─────────────────┼───────────────┼───────────────┼────────────┤
│ Popularity      │ ★★★★☆ (4.2k) │ ★★★☆☆ (1.1k) │ ★★☆☆☆ (320)│
│ Maintenance     │ ★★★★★ Active  │ ★★★☆☆ Weekly │ ★★☆☆☆ Monthly│
│ Documentation   │ ★★★★★ Complete │ ★★★☆☆ Basic  │ ★☆☆☆☆ Poor │
│ Performance     │ ★★★★★ O(1)    │ ★★★☆☆ O(n)   │ ★★★★☆ O(log)│
│ Type Safety     │ ★★★★★ Full    │ ★★★☆☆ Partial│ ★☆☆☆☆ None │
│ Bundle Size     │ ★★★☆☆ 45kb   │ ★★★★★ 12kb   │ ★★★★☆ 25kb │
│ Ecosystem       │ ★★★★★ Rich    │ ★★★☆☆ Limited│ ★★★☆☆ Growing│
│ Learning Curve  │ ★★★☆☆ Medium │ ★★★★★ Easy   │ ★★☆☆☆ Steep │
└─────────────────┴───────────────┴───────────────┴────────────┘
```

---

## 2. SOURCE DISCOVERY HIERARCHY

### Priority Order for Research

```
┌────────────────────────────────────────────────────────────┐
│  1. OFFICIAL DOCUMENTATION  (Primary Source)              │
│     - Official docs, API reference, guides                 │
│     - Source: docs.official.com                           │
├────────────────────────────────────────────────────────────┤
│  2. SPECIFICATIONS & RFCS     (Definitive Source)        │
│     - Language specs, protocol specs, RFCs                │
│     - Source: tools.ietf.org, github.com/tc39             │
├────────────────────────────────────────────────────────────┤
│  3. CONTEXT7 / MCP TOOLS     (AI-Enhanced Search)        │
│     - Natural language queries to docs                    │
│     - Source: Context7, GitHub MCP                       │
├────────────────────────────────────────────────────────────┤
│  4. COMMUNITY RESOURCES      (Secondary)                  │
│     - Stack Overflow, Reddit, dev.to                     │
│     - Good for real-world issues                         │
├────────────────────────────────────────────────────────────┤
│  5. BENCHMARKS & COMPARISONS (Verification)              │
│     - Independent benchmarks, comparisons                 │
│     - Source: GitHub repos, technical blogs              │
├────────────────────────────────────────────────────────────┤
│  6. SOURCE CODE             (Ground Truth)               │
│     - Read the actual implementation                     │
│     - Source: GitHub, GitLab                            │
└────────────────────────────────────────────────────────────┘
```

---

## 3. RESEARCH QUERY TEMPLATES

### For Library/Framework Evaluation

```bash
# Context7 query template
context7_query="What is [library] and how does it compare to [alternative]?
Include: features, performance, ecosystem, TypeScript support, maintenance status"

# Direct search template
query_parts=(
  "[library] vs [alternative] comparison 2024"
  "[library] GitHub stars last commit"
  "[library] performance benchmark"
  "[library] known issues limitations"
  "[library] migration guide from [old_lib]"
)
```

### For Error/Solution Research

```bash
# Error research template
error_query="[exact_error_message] [language/framework] [version]"
error_query_narrow="[specific_function] [specific_error_type]"

# Stack Overflow template
site:stackoverflow.com "[error_keywords]" [framework] is:answer
```

### For Best Practices Research

```bash
# Best practices template
query="[topic] best practices [year] [language/framework]"
query_advanced="[topic] enterprise patterns [use_case]"
```

---

## 4. COMPARISON DOCUMENT TEMPLATE

```markdown
# [Library Name] vs [Alternative] — Comparison

## Overview
| Aspect | [Lib A] | [Lib B] |
|--------|---------|---------|
| Version | v2.1.0 | v3.0.0 |
| License | MIT | Apache 2.0 |
| Size | 45kb | 12kb |

## Feature Comparison

| Feature | [Lib A] | [Lib B] |
|---------|---------|---------|
| Feature 1 | ✅ Yes | ⚠️ Partial |
| Feature 2 | ✅ Yes | ✅ Yes |
| Feature 3 | ❌ No | ✅ Yes |

## Performance

| Operation | [Lib A] | [Lib B] |
|-----------|---------|---------|
| Read | 0.1ms | 0.3ms |
| Write | 0.2ms | 0.1ms |
| Memory | 10MB/1k | 8MB/1k |

## Ecosystem

| Aspect | [Lib A] | [Lib B] |
|--------|---------|---------|
| npm downloads | 1M/week | 500k/week |
| GitHub stars | 20k | 8k |
| Contributors | 150+ | 30+ |
| Last release | 2 weeks ago | 1 month ago |

## Use Case Recommendations

- **[Lib A]**: When you need [specific use case]
- **[Lib B]**: When you need [different use case]

## Migration Path

From [A] to [B]:
\`\`\`
Step 1: Install new package
Step 2: Update imports
Step 3: Adjust API calls
Step 4: Test thoroughly
\`\`\`
```

---

## 5. DECISION FRAMEWORK

```python
# Decision matrix calculator
from dataclasses import dataclass
from typing import List
import numpy as np

@dataclass
class Technology:
    name: str
    scores: dict  # criterion -> score (0-10)
    weights: dict  # criterion -> weight (0-1)

def evaluate(tech: Technology) -> float:
    """Calculate weighted score"""
    total = 0
    weight_sum = 0
    for criterion, weight in tech.weights.items():
        score = tech.scores.get(criterion, 5)
        total += score * weight
        weight_sum += weight
    return total / weight_sum if weight_sum > 0 else 0

def compare(tech_a: Technology, tech_b: Technology) -> str:
    """Compare two technologies"""
    score_a = evaluate(tech_a)
    score_b = evaluate(tech_b)
    
    winner = tech_a if score_a > score_b else tech_b
    return f"{winner.name} (score: {max(score_a, score_b):.2f})"


# Example usage
react = Technology(
    name="React",
    scores={
        'performance': 8,
        'ecosystem': 10,
        'learning_curve': 6,
        'type_safety': 7,
        'maintenance': 9,
    },
    weights={
        'performance': 0.25,
        'ecosystem': 0.20,
        'learning_curve': 0.15,
        'type_safety': 0.20,
        'maintenance': 0.20,
    }
)

vue = Technology(
    name="Vue",
    scores={
        'performance': 9,
        'ecosystem': 7,
        'learning_curve': 9,
        'type_safety': 8,
        'maintenance': 8,
    },
    weights={
        'performance': 0.25,
        'ecosystem': 0.20,
        'learning_curve': 0.15,
        'type_safety': 0.20,
        'maintenance': 0.20,
    }
)

print(compare(react, vue))  # Output depends on weighted scores
```

---

## 6. RESEARCH WORKFLOW

```
┌─────────────────────────────────────────────────────────────┐
│                 RESEARCH WORKFLOW                           │
│                                                              │
│  ┌─────────┐    ┌──────────┐    ┌──────────┐    ┌─────────┐  │
│  │ DEFINE  │───▶│ DISCOVER │───▶│ ANALYZE  │───▶│ DECIDE  │  │
│  │ Problem │    │ Sources  │    │ Evidence │    │ & Record│  │
│  └─────────┘    └──────────┘    └──────────┘    └─────────┘  │
│       │              │               │               │        │
│       ▼              ▼               ▼               ▼        │
│  Keywords      Official Docs    Performance     Recommendation│
│  Scope         Context7          Comparisons     Trade-offs   │
│  Criteria      GitHub           Real-world     Documentation │
│                Community         issues                      │
└─────────────────────────────────────────────────────────────┘
```

### Step 1: Define Problem
```python
research = {
    'question': 'Which state management for React in 2024?',
    'constraints': ['TypeScript', 'Large app', 'Performance critical'],
    'alternatives': ['Redux Toolkit', 'Zustand', 'Jotai', 'Valtio'],
    'criteria': ['bundle_size', 'performance', 'DX', 'type_safety'],
}
```

### Step 2: Discover Sources
```python
sources = [
    'context7:react state management comparison',
    'github:redux-toolkit stars last_commit',
    'github:zustand stars last_commit',
    'stackoverflow:best react state management 2024',
    'npm:redux toolkit downloads weekly',
    'benchmark:react state management perf',
]
```

### Step 3: Analyze Evidence
```python
analysis = {
    'redux_toolkit': {
        'pros': ['Battle-tested', 'Excellent devtools', 'RTK Query'],
        'cons': ['Boilerplate', 'Bundle size', 'Learning curve'],
        'metrics': {'stars': '25k', 'downloads': '5M/week'},
    },
    'zustand': {
        'pros': ['Minimal', 'Fast', 'Simple API'],
        'cons': ['Smaller ecosystem', 'Less formal'],
        'metrics': {'stars': '15k', 'downloads': '1M/week'},
    },
}
```

### Step 4: Decision & Documentation
```python
recommendation = {
    'for_large_app': 'Redux Toolkit (mature, devtools, RTK Query)',
    'for_simple_app': 'Zustand (minimal, fast, easy)',
    'decision_factors': {
        'performance_critical': 'Zustand (faster, smaller)',
        'team_experience': 'Redux Toolkit (battle-tested)',
    },
}
```

---

## 7. OBSIDIAN INTEGRATION

```bash
# Research output template for Obsidian vault

# File: vault/50-RESEARCH/[topic]-[date].md

---
type: research
date: 2024-01-15
status: completed
libraries: [zustand, redux-toolkit]
decision: zustand
confidence: high
---

# [Topic] Research — [Date]

## Question
[Original research question]

## Decision
[Selected solution]

## Alternatives Considered

### [Alternative 1]
**Pros:** ...
**Cons:** ...

### [Alternative 2]
**Pros:** ...
**Cons:** ...

## Comparison Table

| Criteria | Weight | [Alt 1] | [Alt 2] |
|----------|--------|---------|---------|
| Performance | 30% | 8 | 9 |
| Ecosystem | 25% | 9 | 7 |
| ... | ... | ... | ... |

## Key Findings

1. [Finding 1]
2. [Finding 2]
3. [Finding 3]

## Action Items

- [ ] Integrate [chosen library]
- [ ] Set up devtools
- [ ] Document patterns

## Next Review
[Date + 6 months]
```

---

*This file is part of Delegado OS - RESEARCHER Agent Mode*
