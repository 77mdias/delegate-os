# Mentor Mode Example: Senior Engineer Career Roadmap

**Mode**: Mentor  
**Type**: Career Development  
**Date**: 2024-01-15  
**Duration**: 2 hours (ongoing)

---

## Context

**Mentee Profile**:
- Name: Alex Chen
- Current Role: Mid-Level Software Engineer (4 years experience)
- Company: TechStartup Inc. (150 employees)
- Tech Stack: Python, Django, React, PostgreSQL
- Goal: Senior Engineer within 18 months

**Assessment Summary**:
- Strong technical fundamentals
- Good communication skills
- Limited system design experience
- No prior mentorship or leadership experience
- Focused on backend development

---

## Career Trajectory Analysis

### Target Role: Senior Software Engineer

**Required Competencies**:

| Competency | Current Level | Target Level | Gap |
|------------|--------------|--------------|-----|
| Technical Expertise | Proficient | Expert | Medium |
| System Design | Basic | Advanced | High |
| Code Review | Intermediate | Advanced | Medium |
| Mentorship | None | Foundational | High |
| Technical Communication | Intermediate | Advanced | Medium |
| Project Estimation | Basic | Advanced | High |
| Cross-team Collaboration | Basic | Intermediate | Medium |

---

## Roadmap Timeline

### Phase 1: Foundation (Months 1-3)

#### Month 1: Deepen Technical Expertise

**Goals**:
- Master at least one design pattern per week
- Read "Designing Data-Intensive Applications" (chapters 1-5)
- Complete system design exercises daily

**Weekly Activities**:
```
Week 1: Singleton, Factory Method
Week 2: Observer, Strategy
Week 3: Adapter, Decorator
Week 4: Builder, Prototype
```

**Resources**:
- [Design Patterns: Elements of Reusable Software](https://www.amazon.com/Design-Patterns-Elements-Reusable-Object-Oriented/dp/0201633612)
- [System Design Interview Overview](https://github.com/checkyourell/DevOps-Interview-Questions#system-design)

**Success Metrics**:
- [ ] Can explain 12+ GoF patterns with use cases
- [ ] Completed 20 system design exercises
- [ ] Book progress: Chapters 1-5 complete

#### Month 2: System Design Fundamentals

**Goals**:
- Complete system design course
- Design 3 real systems from scratch
- Participate in architecture decisions at work

**Projects**:
1. Design a URL shortening service
2. Design a real-time chat application
3. Design an image processing pipeline

**Key Learnings**:
```
URL Shortener:
├── Requirements Analysis
│   ├── Functional: redirect, create, analytics
│   └── Non-functional: 99.9% uptime, low latency
├── Data Model
│   ├── URL mapping: {short_code -> original_url}
│   └── Analytics: {short_code -> click_count}
├── API Design
│   ├── POST /shorten {url}
│   └── GET /{short_code}
└── Scaling Strategy
    ├── Read-heavy: caching layer
    └── Distribution: consistent hashing
```

**Success Metrics**:
- [ ] Completed system design course
- [ ] 3 system designs documented
- [ ] Made one architecture suggestion at work

#### Month 3: Code Review Skills

**Goals**:
- Lead 10 code reviews
- Provide constructive feedback on 20 PRs
- Learn review best practices

**Code Review Framework**:

```markdown
## Code Review Checklist

### Correctness
- [ ] Does the code do what it claims?
- [ ] Are edge cases handled?
- [ ] Are there potential bugs?

### Design
- [ ] Is the design appropriate for the problem?
- [ ] Are there better patterns to use?
- [ ] Is the code maintainable?

### Readability
- [ ] Is the code self-documenting?
- [ ] Are variable/function names clear?
- [ ] Are comments helpful (not redundant)?

### Performance
- [ ] Are there N+1 query issues?
- [ ] Could algorithms be more efficient?
- [ ] Are resources properly managed?
```

**Success Metrics**:
- [ ] Led 10 code reviews
- [ ] Received positive feedback on reviews
- [ ] Created team code review guidelines

---

### Phase 2: Expansion (Months 4-9)

#### Months 4-6: Mentorship Fundamentals

**Goals**:
- Mentor one junior developer
- Present one technical topic to the team
- Write 4 technical blog posts

**Mentorship Structure**:

```
Week 1-2: Getting to Know Mentee
├── Understand their background
├── Discuss career goals
└── Establish communication rhythm

Week 3-4: Code Review Practice
├── Review their code together
├── Model good feedback
└── Let them practice giving feedback

Week 5-6: Pair Programming
├── Solve problems together
├── Talk through decision-making
└── Demonstrate debugging techniques

Week 7-8: Independent Work
├── Let them lead a small task
├── Provide guidance when asked
└── Give constructive feedback
```

**Success Metrics**:
- [ ] Mentored 1 junior for 3+ months
- [ ] Delivered 1 team presentation
- [ ] Published 4 blog posts

#### Months 7-9: Cross-functional Skills

**Goals**:
- Participate in cross-team project
- Work with product manager on requirements
- Lead estimation for a feature

**Collaboration Framework**:

```
1. Requirements Gathering
   └── Ask "why" 5 times to understand root cause

2. Technical Estimation
   ├── Break into tasks
   ├── Estimate each task
   ├── Add buffer for unknowns
   └── Present range (not single number)

3. Risk Identification
   ├── Technical risks
   ├── Dependencies
   └── Timeline risks

4. Stakeholder Communication
   ├── Weekly updates
   ├── Blockers identified early
   └── Celebrate wins
```

---

### Phase 3: Senior Readiness (Months 10-18)

#### Months 10-12: Leadership Emergence

**Goals**:
- Lead a team of 3-4 engineers
- Drive technical decisions for a feature
- Mentor 2 junior developers

**Leadership Activities**:

```markdown
### Week: Technical Decision Meeting

Before Meeting:
- [ ] Research options
- [ ] Prepare trade-off analysis
- [ ] Anticipate questions

During Meeting:
- [ ] Present options clearly
- [ ] Facilitate discussion
- [ ] Drive to decision
- [ ] Document rationale

After Meeting:
- [ ] Communicate decision
- [ ] Address concerns
- [ ] Update documentation
```

#### Months 13-18: Senior Engineer Demonstration

**Milestones**:
1. Drive architecture of significant feature
2. Resolve complex production incident
3. Improve team processes measurably
4. Interview and onboard new engineers
5. Present at internal tech talk

**Impact Examples**:

| Area | Before | After | Improvement |
|------|--------|-------|-------------|
| Code Review Time | 48 hours | 24 hours | 50% faster |
| Deployment Frequency | Weekly | Daily | 5x more |
| Production Incidents | 8/month | 2/month | 75% reduction |
| Onboarding Time | 3 months | 6 weeks | 33% faster |

---

## Monthly Checkpoints

### Progress Tracking

```markdown
## Month X Checkpoint

### Completed This Month
1.
2.
3.

### Challenges Faced
1.
2.

### Next Month Goals
1.
2.

### Support Needed
1.
```

### Quarterly Review Structure

```yaml
review:
  date: 2024-04-15
  
  competencies:
    technical_expertise: 3/5    # Before: 2/5
    system_design: 2/5         # Before: 1/5
    code_review: 3/5           # Before: 2/5
    mentorship: 2/5             # Before: 0/5
    
  blockers: []
  
  adjustments:
    - "Focus more on system design practice"
    - "Seek more code review opportunities"
    
  next_quarter_goals:
    - "Complete system design course"
    - "Lead first mentor relationship"
    - "Present at team tech talk"
```

---

## Recommended Resources

### Books

1. **"Designing Data-Intensive Applications"** - Martin Kleppmann
2. **"The Staff Engineer's Path"** - Tanya Reilly
3. **"Accelerate"** - Nicole Forsgren et al.
4. **"Mentoring from the Inside"** - Robert S. Anderson

### Courses

1. [System Design Primer](https://github.com/donnemartin/system-design-primer)
2. [Grokking the System Design Interview](https://www.educative.io/courses/grokking-the-system-design-interview)
3. [Engineering Leadership Course](https://www.linkedin.com/learningPaths/engineering-leadership)

### Communities

- [LeadDev](https://leaddev.com/)
- [MentorCruise](https://mentorcruise.com/)
- [Women Who Code](https://www.womenwhocode.com/)

---

## Success Indicators

**6-Month Milestone**:
- [ ] System design skills demonstrably improved
- [ ] First mentorship relationship started
- [ ] Positive feedback on code reviews
- [ ] Contributed to architecture decision

**12-Month Milestone**:
- [ ] Promoted to Senior Engineer
- [ ] Mentoring 1-2 junior engineers
- [ ] Leading technical discussions
- [ ] Represented team in cross-functional meetings

**18-Month Milestone**:
- [ ] Fully established as Senior Engineer
- [ ] Multiple successful mentorships
- [ ] Driving technical strategy for features
- [ ] Recognized as technical leader

---

## Notes

This roadmap is a living document. Adjust based on:
- Company opportunities and timeline
- Personal circumstances and learning pace
- Emerging technologies and priorities
- Feedback from mentors and managers

---

## Next Steps

1. Schedule initial mentorship pairing
2. Enroll in system design course
3. Set up progress tracking in Obsidian
4. Book monthly check-ins to review progress
