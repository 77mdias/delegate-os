# Mentor Mode Examples

## Example: Junior to Senior Roadmap

**User:** "sou dev júnior com 1 ano de experiência, como posso chegar a sênior?"

**Agent Response:**

```
🌱 MENTOR MODE ACTIVATED

# Career Roadmap: Junior → Senior Developer

## 📊 Current Assessment

Based on your profile (1 year experience):

| Competency | Current | Target (Senior) | Gap |
|------------|---------|-----------------|-----|
| Code Syntax | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 1 |
| System Design | ⭐⭐ | ⭐⭐⭐⭐⭐ | 3 |
| Debugging | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | 2 |
| Communication | ⭐⭐⭐ | ⭐⭐⭐⭐ | 1 |
| Architecture | ⭐ | ⭐⭐⭐⭐⭐ | 4 |
| Leadership | ⭐ | ⭐⭐⭐ | 2 |
| Business Domain | ⭐⭐ | ⭐⭐⭐⭐ | 2 |

**Estimated Time to Senior:** 3-4 years (with focused effort)

---

## 🎯 The Senior Developer Mindset

```
┌────────────────────────────────────────────────────────────────┐
│                    JUNIOR vs SENIOR THINKING                     │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  JUNIOR                                                       │
│  ══════                                                       │
│  "What code should I write?"                                   │
│  "How do I solve this specific bug?"                          │
│  "I need to ask someone before doing this"                    │
│                                                                 │
│  SENIOR                                                       │
│  ══════                                                       │
│  "What's the right solution for this context?"                │
│  "What problems might this approach cause?"                    │
│  "How can I help the team move faster?"                       │
│  "What should we be building next?"                             │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

---

## Phase 1: Foundation (Months 1-6)

### 🎯 Goals
- Master your primary stack
- Learn system design basics
- Build confidence in code decisions

### Weekly Routine
```yaml
Hours breakdown (20h/week dedicated learning):
├── 📚 6h: Structured learning (courses, books)
├── 💻 8h: Personal projects
├── 📝 3h: Writing/Documenting
└── 👥 3h: Community/Networking
```

### Month 1-2: Deepen Stack Knowledge

**If Web Dev (React/Node):**
- [ ] Complete Advanced React Patterns course
- [ ] Build a complex form system from scratch
- [ ] Learn TypeScript deeply (generics, utility types)
- [ ] Read: "Effective TypeScript" by Dan Vanderkam

**If Backend (Python/Go):**
- [ ] Master async/await patterns
- [ ] Build a concurrent API server
- [ ] Learn SQL deeply (indexes, query optimization)
- [ ] Read: "Architecture Patterns with Python"

### Month 3-4: System Design Introduction

**Resources:**
- 📖 "Designing Data-Intensive Applications" (first 6 chapters)
- 🎬 System Design Primer on GitHub
- 🎬 Exponent DM' videos

**Projects:**
- [ ] Design a URL shortener (like bit.ly)
- [ ] Design a chat system (like WhatsApp)
- [ ] Draw architecture diagrams for your work's app

### Month 5-6: Communication & Process

**Skills to Develop:**
- [ ] Write technical documentation
- [ ] Practice explaining code verbally
- [ ] Learn Git branching strategies
- [ ] Participate in code reviews actively

**Daily Habits:**
```javascript
// Before asking for help, try:
// 1. Rubber duck debugging
// 2. Read error message completely
// 3. Search Stack Overflow/GitHub issues
// 4. Read related source code
// 5. Then ask with context
```

---

## Phase 2: Growth (Months 7-18)

### 🎯 Goals
- Design systems independently
- Mentor junior developers
- Lead small features end-to-end

### Technical Skills Matrix

```
┌────────────────────────────────────────────────────────────────┐
│                    SENIOR SKILL REQUIREMENTS                     │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  SYSTEM DESIGN (Must Have)                                     │
│  ─────────────────────────────────────────────────────────────  │
│  □ Can design scalable APIs                                    │
│  □ Understands database trade-offs (SQL vs NoSQL)               │
│  □ Can draw architecture diagrams                               │
│  □ Knows when to cache and when not to                         │
│  □ Understands CAP theorem implications                        │
│                                                                 │
│  CODE QUALITY                                                  │
│  ─────────────────────────────────────────────────────────────  │
│  □ Writes self-documenting code                                 │
│  □ Refactors without fear                                      │
│  □ Knows when to apply patterns (and when NOT to)               │
│  □ Writes tests that give confidence                           │
│  □ Reviews code effectively                                    │
│                                                                 │
│  DEBUGGING                                                     │
│  ─────────────────────────────────────────────────────────────  │
│  □ Uses logs, metrics, traces strategically                     │
│  □ Can debug distributed systems                                │
│  □ Replicates bugs reliably                                    │
│  □ Knows when to add observability vs fix root cause            │
│                                                                 │
│  DELIVERY                                                      │
│  ─────────────────────────────────────────────────────────────  │
│  □ Breaks features into shippable chunks                        │
│  □ Estimates accurately (with buffer)                           │
│  □ Communicates blockers early                                 │
│  □ Prioritizes effectively                                     │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

### Month 7-12: Lead Your First Feature

**Action Items:**
1. Volunteer to own a small feature end-to-end
2. Write the technical spec before coding
3. Present your design to the team
4. Get code reviews, incorporate feedback
5. Deploy and monitor in production

**Story Template for Interviews:**
```markdown
# STAR: Led Feature from Design to Production

**Situation:** Our users were complaining about slow checkout.
**Task:** As the tech lead for checkout optimization...
**Action:** 
- Analyzed New Relic data showing 3s average checkout time
- Proposed caching strategy for cart data
- Implemented Redis cache with 5-minute TTL
- Added optimistic UI updates
**Result:** Checkout time reduced to 800ms, 15% increase in completed orders
```

### Month 13-18: Mentorship & Leadership

**Start Mentoring:**
- [ ] Pair program with junior devs weekly
- [ ] Do code review with constructive feedback
- [ ] Give tech talks at internal meetups
- [ ] Write a team documentation guide

**Leadership Behaviors:**
```
□ Makes decisions with incomplete information
□ Delegates but stays accountable
□ Focuses on team productivity, not just own code
□ Anticipates problems before they happen
□ Says "I don't know, let me research" confidently
```

---

## Phase 3: Senior Ready (Months 19-36)

### 🎯 Goals
- Drive technical decisions for team
- Influence product direction
- Handle cross-team coordination

### Month 19-24: Technical Leadership

**Activities:**
- [ ] Write RFCs for architectural changes
- [ ] Lead technical debt reduction initiatives
- [ ] Represent team in cross-team meetings
- [ ] Interview and assess candidates

**RFC Template:**
```markdown
# RFC: Migration to Microservices

## Status
Draft | Review | Accepted | Rejected

## Summary
Migrate from monolith to microservices for scalability.

## Motivation
- Current: 45min CI pipeline, 2 deploys/day
- Target: 10min CI, continuous deploy

## Proposed Solution
Phase 1: Extract user service
Phase 2: Extract order service
Phase 3: Extract product service

## Trade-offs
PROS:
- Independent scaling
- Faster deploys
- Team autonomy

CONS:
- Complexity increases
- Network latency
- Distributed tracing needed

## Migration Strategy
...
```

### Month 25-36: Strategic Impact

**What Separates Senior from Staff:**
```
SENIOR: "Let's build this feature well"
STAFF: "Should we be building this feature?"

SENIOR: "Our API is slow"
STAFF: "Our API strategy is limiting growth"

SENIOR: "I completed the sprint goals"
STAFF: "I influenced the roadmap to have higher impact"
```

---

## 📅 90-Day Action Plan

### This Month
- [ ] Read "Clean Code" by Robert Martin
- [ ] Complete one system design exercise weekly
- [ ] Start a technical blog (even if private)
- [ ] Pair program 2x/week with someone more senior

### This Quarter
- [ ] Own a feature end-to-end
- [ ] Write 2 technical documents for the team
- [ ] Get 360 feedback from 3 colleagues
- [ ] Identify your top 3 growth areas

### This Year
- [ ] Lead a technical initiative
- [ ] Mentor 1 junior developer
- [ ] Present at a tech conference/meetup
- [ ] Have 3 STAR stories ready for interviews

---

## 📚 Recommended Resources

### Books (Priority Order)
1. "Clean Code" - Robert Martin
2. "Designing Data-Intensive Applications" - Martin Kleppmann
3. "The Pragmatic Programmer" - Hunt & Thomas
4. "System Design Interview" - Alex Xu

### Courses
1. Udemy: Advanced React Patterns
2. Frontend Masters: Production-Grade TypeScript
3. Coursera: Cloud Architecture (Google)

### Podcasts
- Syntax FM (web dev focused)
- Software Engineering Daily
- The Changelog

---

## 🎤 Interview Preparation

### Common Senior Developer Questions

**Q: "Tell me about a technical challenge you overcame"**
```
STAR Framework:
- Situation: API performance was degrading
- Task: As the backend lead, needed to fix
- Action: 
  1. Profiled with New Relic
  2. Found N+1 query problem
  3. Implemented batching + caching
  4. Added query monitoring
- Result: API latency reduced 70%, p99 from 2s to 400ms
```

**Q: "How do you handle disagreements with other engineers?"**
```
Key points:
- Focus on data, not opinions
- Propose experiments when possible
- Consider "disagree and commit" for low-risk decisions
- Escalate only after exhausting technical discussion
```

**Q: "What makes code 'senior-level'?"**
```
Answer:
1. Readable without comments (self-documenting)
2. Testable and tested
3. Appropriate abstractions (not over/under engineered)
4. Handles errors gracefully
5. Performant when needed
6. Maintainable by others
```

---

**Plan saved to:** `vault/60-CAREER/[your-name]/junior-to-senior-roadmap.md`
**Next check-in:** Schedule monthly review of this plan
```

---

**Related Examples:**
- [EX-TDD.md](../PROFESSOR/EX-TDD.md) - Technical skill building
- [EX-PATTERN.md](../ARCHITECT/EX-PATTERN.md) - System design skills
