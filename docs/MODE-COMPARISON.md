# Agent Mode Comparison

## Quick Reference Table

| Mode | Best For | Output | Time to Value | Expertise Level |
|------|----------|--------|---------------|-----------------|
| **PROFESSOR** | Learning new concepts | Markdown docs | Fast | Beginner+ |
| **ARCHITECT** | System design | Diagrams, ADRs | Medium | Intermediate |
| **DEBUGGER** | Solving bugs | Root cause + fix | Fast | Intermediate+ |
| **GUARDIAN** | Security review | Security report | Medium | Advanced |
| **RESEARCHER** | Tech evaluation | Comparison reports | Slow | Intermediate |
| **MENTOR** | Career growth | Learning path | Slow | All levels |
| **CONSULTANT** | Business decisions | Proposals | Medium | Advanced |
| **ORCHESTRATION** | Complex tasks | Multi-mode output | Slow | Advanced |

## Detailed Mode Profiles

### PROFESSOR
**When to use:**
- Learning a new language, framework, or tool
- Understanding a concept (patterns, algorithms)
- Onboarding to a codebase
- Preparing for interviews

**Don't use when:**
- Need production code immediately
- Have a specific bug to fix
- Making architectural decisions

**Combines well with:** RESEARCHER, MENTOR

### ARCHITECT
**When to use:**
- Starting a new project
- Major refactoring
- Evaluating microservices vs monolith
- Designing API contracts

**Don't use when:**
- Quick prototype needed
- Only need to fix a bug
- Small, simple changes

**Combines well with:** RESEARCHER (tech research), CONSULTANT (cost analysis)

### DEBUGGER
**When to use:**
- Bug reproduction and analysis
- Memory leak investigation
- Performance profiling
- Race condition finding

**Don't use when:**
- Need to learn concept
- Writing new feature
- Security audit required

**Combines well with:** GUARDIAN (security bugs), ARCHITECT (design issues)

### GUARDIAN
**When to use:**
- Pre-production security review
- OWASP compliance check
- Dependency vulnerability scan
- Authentication/authorization audit

**Don't use when:**
- Learning phase
- Pure functionality development
- Performance optimization

**Combines well with:** DEBUGGER (security bugs), REVIEW (code quality)

### RESEARCHER
**When to use:**
- Choosing between technologies
- Evaluating libraries
- Performance benchmarking
- Market analysis

**Don't use when:**
- Need immediate fix
- Teaching a concept
- Design decisions needed

**Combines well with:** ARCHITECT (design), PROFESSOR (learning material)

### MENTOR
**When to use:**
- Career planning
- Skill gap analysis
- Interview preparation
- Leadership development

**Don't use when:**
- Technical implementation needed
- Security review required
- Quick question answered

**Combines well with:** PROFESSOR (technical learning), RESEARCHER (tech choices)

### CONSULTANT
**When to use:**
- Build vs buy decisions
- Vendor evaluation
- Project feasibility studies
- ROI analysis

**Don't use when:**
- Implementation phase
- Bug fixing
- Daily coding tasks

**Combines well with:** ARCHITECT (design), GUARDIAN (risk analysis)

### ORCHESTRATION
**When to use:**
- Complex multi-mode tasks
- Full application development
- End-to-end problem solving
- Large refactoring projects

**Don't use when:**
- Simple, single-mode task
- Quick question
- Learning a concept

**Combines well with:** All modes as needed

## Mode Combination Recipes

### Recipe 1: New Project
```
RESEARCHER → ARCHITECT → CONSULTANT → CODER
(1-2 days)
```
1. Research tech stack
2. Design architecture
3. Validate business case
4. Implement

### Recipe 2: Bug Fix
```
DEBUGGER → GUARDIAN → CODER → REVIEW
(hours to 1 day)
```
1. Find root cause
2. Check security implications
3. Implement fix
4. Review code

### Recipe 3: Security Audit
```
GUARDIAN → DEBUGGER → ARCHITECT → GUARDIAN
(1-3 days)
```
1. Initial security scan
2. Deep dive on findings
3. Recommend architectural changes
4. Final security review

### Recipe 4: Learning Path
```
PROFESSOR → RESEARCHER → MENTOR → PROFESSOR
(ongoing)
```
1. Learn concepts
2. Research best practices
3. Plan career steps
4. Deepen specific knowledge

### Recipe 5: Code Review Pipeline
```
GUARDIAN → REVIEW → CODER → GUARDIAN
(per PR)
```
1. Security check
2. Quality review
3. Apply fixes
4. Final security sign-off

## Mode Switching Triggers

| From | To | Trigger |
|------|-----|---------|
| DEBUGGER | GUARDIAN | Bug has security implications |
| ARCHITECT | RESEARCHER | Need more tech info |
| PROFESSOR | CODER | User ready to implement |
| MENTOR | PROFESSOR | Career → technical gap |
| CONSULTANT | ARCHITECT | Feasible → design needed |
| ORCHESTRATION | [Any] | Delegating sub-task |

## Context Preservation Between Modes

When switching modes, preserve:
- **User intent**: What they're trying to achieve
- **Constraints**: Budget, time, tech stack
- **Decisions made**: Already agreed upon choices
- **Pain points**: What's been difficult

## Mode Selection Algorithm

```
1. Parse user request
2. Extract intent keywords
3. Match to primary mode
4. Check for secondary needs
5. If complex → ORCHESTRATION with multiple modes
6. If unclear → Ask clarifying question
```

## Common Mistakes

1. **Using DEBUGGER for learning** → Use PROFESSOR
2. **Using ARCHITECT for quick fix** → Use DEBUGGER
3. **Skipping RESEARCHER** → Make uninformed tech choices
4. **No GUARDIAN on security** → Vulnerabilities slip through
5. **ORCHESTRATION for simple tasks** → Overkill, use single mode
