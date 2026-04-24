# Advanced Prompt Engineering Guide

## Overview

This guide covers advanced prompt engineering techniques to maximize the effectiveness of Delegado OS agent modes.

## Chain of Thought (CoT)

### What It Is
Chain of Thought encourages the model to think step-by-step, showing its reasoning process.

### When to Use
- Complex problem solving
- Multi-step analysis
- Debugging scenarios
- Architecture decisions

### Implementation

```
Problem: User reports login bug

Chain of Thought prompt:
"Think through this step by step:
1. What are the possible causes of a login bug?
2. What information do I need to diagnose?
3. How would I reproduce this?
4. What tools would help?

Then provide your analysis."
```

### Delegado OS Usage

In DEBUGGER mode, use CoT by default:
```
You are DEBUGGER mode. Think through problems step by step,
showing your diagnostic reasoning before providing solutions.
```

## Tree of Thought (ToT)

### What It Is
Explores multiple solution paths simultaneously, like a decision tree.

### When to Use
- Architecture decisions with trade-offs
- Technology selection
- Complex debugging with multiple hypotheses

### Implementation

```
For the auth architecture, explore 3 paths:
- Path A: JWT with refresh tokens
- Path B: OAuth 2.0 with PKCE
- Path C: SAML for enterprise

For each path, evaluate: complexity, security, scalability, cost.
```

### Delegado OS Usage

In ARCHITECT mode:
```
Consider 3 architectural approaches for this system.
For each, analyze trade-offs and recommend the best fit.
```

## ReAct (Reasoning + Acting)

### What It Is
Combines reasoning with the ability to use tools and take actions.

### When to Use
- Tasks requiring tool use
- Multi-step workflows
- Research with web searches

### Implementation

```
Thought: I need to find the latest FastAPI best practices.
Action: search_context7["fastapi best practices 2024"]
Observation: Results show...
Thought: Based on this, I should...
Action: ...
```

### Delegado OS Usage

In RESEARCHER mode:
```
Use the Context7 search to find current best practices.
For each finding, note the source and evaluate reliability.
```

## Self-Consistency

### What It Is
Generates multiple reasoning paths and selects the most consistent answer.

### When to Use
- Critical security decisions
- High-stakes architecture choices
- When confidence matters

### Implementation

```
Solve this problem 3 different ways:
1. From a security perspective
2. From a performance perspective  
3. From a maintainability perspective

Then identify the most robust solution that satisfies all.
```

### Delegado OS Usage

In GUARDIAN mode:
```
Analyze this code from multiple security angles:
- OWASP Top 10 compliance
- Common vulnerability patterns
- Defense in depth

Synthesize findings into a security report.
```

## Prompt Chaining

### What It Is
Breaks complex tasks into linked prompts where each output feeds into the next.

### When to Use
- Multi-phase workflows
- Document generation
- Complex debugging sessions

### Implementation

```
Chain:
1. "Analyze this error log and identify the root cause"
2. "Based on [root cause], suggest 3 fix approaches"
3. "For the recommended fix, write the code and tests"
```

### Delegado OS Usage

This is how HELL phases work:
```
H (Hook): Gather context
E (Educate): Research and learn
L (Link): Connect findings
L (Loop): Verify and iterate
```

## Few-Shot Learning

### What It Is
Provides examples in the prompt to guide the model's output format and style.

### When to Use
- Ensuring consistent output format
- Teaching specific response styles
- Mode-specific behaviors

### Implementation

```
Example interaction:
User: "Explain async/await"
Output: "## Concept: Async/Await\n\n### What it is...\n\n### Example...\n### When to use..."

User: "How do decorators work?"
Output: [Same format as above]
```

### Delegado OS Usage

In PROFESSOR mode SKILL.md:
```
Always use this format when teaching:
1. Concept (2-3 sentences)
2. Why it matters (1 sentence)
3. Code example (fully functional)
4. Common pitfall (1 sentence)
5. Practice exercise (1 task)
```

## Role Prompting

### What It Is
Assigns a specific persona that shapes all responses.

### Implementation

```
You are GUARDIAN mode - a security expert with 20 years experience.
You think like an attacker first, then a defender.
You always consider: CIA (Confidentiality, Integrity, Availability).

When reviewing code, you look for:
- Injection vulnerabilities
- Authentication flaws
- Data exposure
- ...
```

## Context Injection

### What It Is
Dynamically adds relevant context to prompts.

### Implementation

```
Based on our previous session where we discussed microservices,
and considering the constraints you mentioned (team of 5, 3-month timeline),
recommend an architecture for the user management service.
```

### Delegado OS Implementation

Use pre-hooks to inject context:
```bash
# In pre_PROFESSOR.sh
CONTEXT=$(cat "$DELEGADO_HOME/.delegado/last_discussion.md" 2>/dev/null)
export INJECTED_CONTEXT="$CONTEXT"
```

## Constraint-Based Prompting

### What It Is
Explicitly states what the model should and shouldn't do.

### Implementation

```
You are DEBUGGER mode.

Constraints:
- Do NOT make changes without explaining why
- Always verify fixes with a test
- If unsure, say "I need more information"
- Focus on root cause, not symptoms

Output format:
1. Root cause: [...]
2. Fix approach: [...]
3. Test verification: [...]
4. Prevention: [...]
```

## Meta-Prompting

### What It Is
Prompts the model to refine its own prompts.

### Implementation

```
After each response, evaluate:
1. Did I fully answer the user's question?
2. Was my explanation clear?
3. Did I provide actionable next steps?
4. What could I improve?

If any answer is no, provide an improved response.
```

## Combining Techniques

### Complex Debugging Session

```markdown
You are DEBUGGER mode with deep security expertise.

Think step-by-step (CoT):
1. Analyze error: [error log]
2. Possible causes: [list]
3. Most likely: [reasoning]
4. Verify: [test plan]
5. Fix: [with code]

Consider 3 hypotheses (ToT):
- Hypothesis A: Race condition
- Hypothesis B: Memory issue
- Hypothesis C: Configuration error

For each, show your reasoning before concluding.

Output format:
## Root Cause: [clear statement]
## Confidence: [High/Medium/Low]
## Fix: [code]
## Test: [verification steps]
## Prevention: [how to avoid in future]
```

### Teaching Session

```markdown
You are PROFESSOR mode.

Use this structure (Few-Shot):
1. Hook: Start with a real-world problem this solves
2. Concept: Explain in 3 sentences
3. Demo: Working code example
4. Pitfall: Common mistake
5. Exercise: Practice task

Engage the student (ReAct):
- Ask clarifying questions
- Adjust depth based on responses
- Connect to their specific project

After each explanation, ask:
"Does this make sense, or should I elaborate on any part?"
```

## Prompt Templates by Mode

### PROFESSOR
```
[Concept to teach]: {input}
Format:
- Hook (engaging opening)
- Explanation (clear, beginner-friendly)
- 3 Examples (simple → complex)
- Common mistake
- Practice exercise
```

### ARCHITECT
```
[System to design]: {input}
Consider:
- Functional requirements
- Non-functional requirements
- Constraints
- Trade-offs

Output:
- Architecture diagram (text-based)
- Component descriptions
- Data flow
- Decision rationale (3 options compared)
```

### DEBUGGER
```
[Error/Issue]: {input}
Approach:
1. Reproduce (steps to verify)
2. Diagnose (root cause analysis)
3. Fix (with code)
4. Verify (test that proves fix)
5. Prevent (pattern/lesson learned)
```

### GUARDIAN
```
[Code/Design to audit]: {input}
Security angles:
- OWASP Top 10
- Authentication/Authorization
- Data protection
- Common vulnerabilities

Output:
- Severity ratings (Critical/High/Medium/Low)
- Findings with evidence
- Recommendations
- Mitigation steps
```

## Testing Your Prompts

1. **Run same input twice** - should get consistent output
2. **Vary edge cases** - test boundaries
3. **Check format adherence** - does output match template?
4. **Evaluate depth** - is it thorough enough?
5. **Measure token usage** - is it efficient?

## Iterative Improvement

```bash
# Run auto-improvement analysis
./scripts/auto_improve.sh analyze --mode PROFESSOR

# Results show:
# - Average response length
# - Format consistency
# - Common issues
# - Improvement suggestions
```
