# Strategic Consulting Frameworks

> Decision-making and problem-solving frameworks for the CONSULTANT agent.

## 1. DECISION FRAMEWORKS

### RAPID Decision Model

```
┌─────────────────────────────────────────────────────────────┐
│                      RAPID FRAMEWORK                         │
│                                                              │
│   R ─── Recommend ──▶ Makes proposal, does analysis          │
│   A ─── Agree      ──▶ Must sign off on decision            │
│   P ─── Perform    ──▶ Does the work, implements            │
│   I ─── Input      ──▶ Provides expertise, feedback         │
│   D ─── Decide     ──▶ Makes final call                      │
│                                                              │
│   Example: Approve new feature                              │
│   ─────────────────────────────────────────────               │
│   R = Tech Lead (proposal)                                  │
│   A = VP Engineering (budget)                               │
│   P = Development team (implementation)                    │
│   I = Security team (review)                                │
│   D = Product Manager (priority)                           │
└─────────────────────────────────────────────────────────────┘
```

### A3 Thinking (Toyota Method)

```python
a3_thinking = {
    'background': {
        'problem': 'What is the issue?',
        'current_state': 'How does it work today?',
        'goal_state': 'How should it work?',
        'scope': 'What's included/excluded?',
    },
    'root_cause': {
        'analysis': 'Why does it happen?',
        'techniques': ['5 Whys', 'Ishikawa diagram', 'Pareto'],
    },
    'proposed_actions': {
        'options': ['What can we do?', 'Trade-offs of each'],
        'selection': 'Why this approach?',
    },
    'implementation': {
        'plan': 'What, who, when?',
        'timeline': 'Schedule with milestones',
        'resources': 'What do we need?',
    },
    'follow_up': {
        'results': 'How do we measure success?',
        'sustain': 'How do we prevent recurrence?',
    },
}
```

---

## 2. PROBLEM SOLVING FRAMEWORKS

### First Principles Thinking

```python
first_principles = """
# Instead of: "We've always done it this way"

# Break down problem to fundamental truths:

What do we BELIEVE to be true?
  └─ Why do we believe this?
      └─ Is this actually true?

# Rebuild from scratch:

What MUST be true for this to work?
  └─ What are the essential elements?
      └─ Can we achieve each element?

# Example:
# OLD: "We need a monolith because that's how we've always done it"
# NEW: 
#   - We need: Fast deployment, scalability, maintainability
#   - Microservices: ✓ (but complex)
#   - Modular Monolith: ✓ (simpler, can evolve)
#   - Decision: Start with Modular Monolith
"""
```

### Second Order Thinking

```python
second_order = """
# First Order: "If we cut prices, we'll sell more"
# Second Order: "And then?"
#   - And then competitors cut prices too
#   - And then margins shrink
#   - And then we can't invest in quality
#   - And then customers leave anyway

# Decision matrix:
| Decision | 1st Order | 2nd Order | 3rd Order |
|----------|-----------|------------|------------|
| Cut price | +10% sales | -5% margin | Competitor war |
| Add feature | +20% users | +30% complexity | -40% velocity |
| No action | Maintain | Lose market | Potential exit |
"""
```

---

## 3. STRATEGIC PLANNING

### OKR Framework

```markdown
## OKR Template

### Objective: [Inspiring statement of what to achieve]

#### Key Result 1: [Specific, measurable outcome]
- Initiative: [Project/action]
- Initiative: [Project/action]

#### Key Result 2: [Specific, measurable outcome]
- Initiative: [Project/action]

#### Key Result 3: [Specific, measurable outcome]
- Initiative: [Project/action]

## Example

### Objective: Become the industry leader in developer experience

#### KR1: Achieve NPS score of 50+
- Launch developer portal redesign
- Implement feedback system
- Monthly NPS review

#### KR2: Reduce time-to-first-CLI from 10min to 2min
- One-command install
- Guided onboarding
- Interactive tutorial

#### KR3: 100 enterprise customers using SDK
- Enterprise outreach program
- Dedicated enterprise support
- Success stories and case studies
```

### Wardley Mapping (Simplified)

```
┌─────────────────────────────────────────────────────────────┐
│                      WARDLEY MAPPING                        │
│                                                              │
│   INVISIBLE │                                    ▲           │
│             │                               Chain ⚡         │
│             │                           Commodity ⚡         │
│             │                       Product ⚡              │
│             │                     Custom-Built ⚡            │
│             │                 Prototype ⚡                   │
│             │              Genesis ⚡                         │
│             │                                            ▼   │
│   VISIBLE  │                                              │
│             │            Evolution axis ─────────────────▶  │
│                                                              │
│   Mapping Questions:                                         │
│   - Where are we now?                                       │
│   - Where are we going?                                     │
│   - What's the competition doing?                           │
│   - What should we build vs buy?                           │
└─────────────────────────────────────────────────────────────┘
```

---

## 4. RISK ANALYSIS

### Risk Matrix

```
              IMPACT
         Low      Medium      High
     ┌────────┬────────┬────────┐
Low  │  Monitor│  Mitigate │  Mitigate │
     ├────────┼────────┼────────┤
LIKELIHOOD│ Medium│ Mitigate │  Transfer │
     ├────────┼────────┼────────┤
     │ High  │  Transfer│   Avoid   │
     └────────┴────────┴────────┘

Mitigate = Reduce likelihood or impact
Transfer = Insurance, partnerships, contracts
Avoid = Change plan to eliminate risk
Monitor = Accept and watch
```

### Risk Assessment Template

```markdown
## Risk Assessment: [Project/Decision]

### Risk 1: [Description]
- **Category:** Technical / Financial / Operational / Compliance
- **Likelihood:** Low / Medium / High
- **Impact:** Low / Medium / High
- **Overall:** [Calculate from matrix]
- **Mitigation:** [Specific actions]
- **Contingency:** [If mitigation fails]
- **Owner:** [Who owns this risk]
- **Status:** [Open / Mitigated / Closed]

### Risk 2: ...

### Top 3 Risks
1. [Risk with highest overall score]
2. [Second highest]
3. [Third highest]
```

---

## 5. TRADE-OFF ANALYSIS

### The 3-Way Trade-Off Framework

```python
trade_off_framework = """
# Every significant decision has trade-offs

TRADE-OFF: Speed vs Quality vs Cost

        ┌─────────────────────────────────────┐
        │         PICK ANY TWO                │
        │                                      │
        │     ┌─────────┐                      │
        │     │  FAST   │                      │
        │     │   +     │                      │
        │     │ CHEAP   │                      │
        │     └─────────┘                      │
        │         =                            │
        │     NOT QUALITY                      │
        │                                      │
        │     ┌─────────┐                      │
        │     │  FAST   │                      │
        │     │   +     │                      │
        │     │QUALITY  │                      │
        │     └─────────┘                      │
        │         =                            │
        │      NOT CHEAP                        │
        │                                      │
        └─────────────────────────────────────┘

# Common Software Trade-offs:

| We Want      | Trade-off        | Solution              |
|--------------|------------------|-----------------------|
| Features     | Complexity       | Ruthless prioritization|
| Speed        | Quality          | Technical debt tracking|
| Flexibility  | Performance      | Abstraction layers    |
| Security     | Usability        | UX research           |
| Consistency  | Innovation       | Pattern libraries     |
"""
```

---

## 6. INFLUENCE FRAMEWORKS

### Cialdini's 6 Principles (Applied to Technical Decisions)

```python
cialdini_principles = {
    'reciprocity': {
        'apply': 'Share knowledge freely, help others',
        'example': '"I reviewed your PR, happy to help with yours"',
    },
    'commitment': {
        'apply': 'Get small yeses before big asks',
        'example': '"Do you agree X is a problem? Great, so lets fix it"',
    },
    'social_proof': {
        'apply': 'Show what peers are doing',
        'example': '"Netflix, Google, Amazon all solved it this way"',
    },
    'authority': {
        'apply': 'Reference experts and data',
        'example': '"Research shows this pattern is optimal"',
    },
    'liking': {
        'apply': 'Build relationships first',
        'example': 'Know your stakeholders personally',
    },
    'scarcity': {
        'apply': 'Highlight unique opportunities',
        'example': '"This is the only time we can change this"',
    },
}
```

### Stakeholder Mapping (RACI Alternative)

```python
stakeholder_mapping = {
    'circle_of_influence': [
        'Tech Lead - Can change technical direction',
        'Product Manager - Controls priority',
        'Senior Engineers - Affect implementation',
    ],
    'circle_of_concern': [
        'VP Engineering - Sets budget/direction',
        'CTO - Long-term vision',
        'Other teams - May be impacted',
    ],
    'engagement_strategy': {
        'influence': 'Regular sync, involve early',
        'keep_satisfied': 'Brief updates, avoid surprises',
        'keep_informed': 'Weekly summary',
        'monitor': 'As needed updates',
    },
}
```

---

## 7. CONSULTING ENGAGEMENT TEMPLATE

```markdown
# Consulting Engagement: [Topic]

## Executive Summary
[2-3 sentences on the situation and recommendation]

## Situation Analysis
### Current State
- What's working
- What's not working
- Key pain points

### Data
- Relevant metrics
- Industry benchmarks
- Internal data

## Options Considered

### Option A: [Name]
**Description:** [What it is]
**Pros:** [Benefits]
**Cons:** [Drawbacks]
**Investment:** [Cost/time]
**Risk:** [Key risk]

### Option B: [Name]
...

### Option C: [Do Nothing / Status Quo]
...

## Recommendation
[Why this option]
[Key assumptions]
[Expected outcomes]

## Implementation Plan

### Phase 1: Quick Wins (0-30 days)
| Action | Owner | Date | Success Metric |
|--------|-------|------|---------------|
| ... | ... | ... | ... |

### Phase 2: Foundation (30-90 days)
| Action | Owner | Date | Success Metric |
|--------|-------|------|---------------|

### Phase 3: Scale (90-180 days)
| Action | Owner | Date | Success Metric |
|--------|-------|------|---------------|

## Success Criteria
- [ ] Metric 1: Target vs Actual
- [ ] Metric 2: Target vs Actual

## Risks & Mitigations
| Risk | Impact | Probability | Mitigation |
|------|--------|-------------|------------|

## Appendix
- Detailed analysis
- Data sources
- Stakeholder input
```

---

## 8. COMMUNICATION FRAMEWORKS

### Pyramid Principle

```python
pyramid_principle = """
# Structure: Conclusion First, Then Evidence

       ┌─────────────────┐
       │    CONCLUSION   │  ← What you want them to know/do
       │    (Main Point) │
       └────────┬────────┘
                │
       ┌────────┴────────┐
       │    KEY POINTS   │  ← 2-3 supporting arguments
       │  (Sub-messages) │
       └────────┬────────┘
                │
       ┌────────┴────────┐
       │     EVIDENCE    │  ← Data, examples, details
       │   (Supporting)  │
       └─────────────────┘

# Example:

❌ OLD (Email):
"We evaluated 3 vendors. Vendor A has great features but expensive.
Vendor B is cheap but missing features. Vendor C is mid-range but 
has API limitations. We've been using Vendor B for 2 years but..."

✅ NEW (Email):
"RECOMMENDATION: Switch to Vendor C starting Q2
- Saves $50k/year vs current Vendor B
- Has 90% of features we need
- Migration risk: Low (phased approach attached)
Next step: Approve to proceed with pilot in March."

# Context: Your current vendor has issues (details below...)
"""
```

### Messaging Matrix

```markdown
## Audience-Specific Messaging

| Audience | Primary Concern | Message | Channel |
|----------|----------------|---------|---------|
| CTO | Strategic fit, ROI | Business value, risk | 1-on-1 |
| VP Eng | Technical soundness | Architecture, scalability | Technical review |
| PM | Timeline, features | Roadmap impact, priorities | Sprint planning |
| Team | Workload, growth | Learning, challenges | Team meeting |
```

---

*This file is part of Delegado OS - CONSULTANT Agent Mode*
