# Teaching Methodologies

> Comprehensive guide for the PROFESSOR agent on effective teaching strategies.

## 1. THE FOUR CS FRAMEWORK

```
┌──────────────────────────────────────────────────────────┐
│                     FOUR CS FRAMEWORK                    │
├──────────────┬──────────────┬───────────────┬─────────────┤
│  CONNECTION │   CONTENT    │   CONCEPT     │   CODER     │
│             │              │               │             │
│  Hook the   │  Present     │  Deep dive    │  Hands-on   │
│  learner    │  information │  understanding│  practice   │
│  to topic   │  clearly    │  of principles│  coding     │
└──────────────┴──────────────┴───────────────┴─────────────┘
```

### Connection Phase
- Start with a relatable story or analogy
- Ask a provocative question
- Show a real-world problem the learner will solve
- Demonstrate the gap between current and desired state

### Content Phase
- Break complex topics into digestible chunks
- Use visual aids (diagrams, flowcharts)
- Provide code examples at each step
- Maintain progressive complexity

### Concept Phase
- Explain the "why" behind the "what"
- Connect to underlying principles
- Show mental models and frameworks
- Discuss trade-offs and alternatives

### Code Phase
- Step-by-step guided coding
- Progressive challenge increase
- Code along exercises
- Independent practice assignments

---

## 2. BLOOM'S TAXONOMY FOR CODE TEACHING

| Level | Cognitive Skill | Code Example |
|-------|----------------|-------------|
| **1. Remember** | Recall facts | List 5 Python data types |
| **2. Understand** | Explain concepts | Describe how list comprehension works |
| **3. Apply** | Use in new situations | Filter a list using list comprehension |
| **4. Analyze** | Draw connections | Compare list comprehension vs map+filter |
| **5. Evaluate** | Justify decisions | When to use list comprehension vs loops |
| **6. Create** | Produce new work | Design a DSL using list comprehensions |

### Teaching Flow by Bloom Level

```python
# Level 1-2: Foundation
📚 "Python list comprehensions are a way to create lists from iterables..."

# Level 3: Application  
✏️ "[Exercise] Create a list of squares from 1 to 10 using comprehension"

# Level 4: Analysis
🔍 "What's the difference between these two approaches?..."
[f(x) for x in items]  # vs
result = []
for x in items:
    result.append(f(x))

# Level 5: Evaluation
⚖️ "When is each approach better? Consider readability, performance..."

# Level 6: Creation
🚀 "[Project] Build a data transformation pipeline using comprehensions"
```

---

## 3. PROGRESSIVE DISCLOSURE TEACHING

### Layer 1: The Hook (30 seconds)
```
"Imagine writing 50 lines of code in 1 line..."
```

### Layer 2: Simple Demo (2 minutes)
```python
# The simplest possible example
numbers = [1, 2, 3, 4, 5]
squares = [x**2 for x in numbers]
print(squares)  # [1, 4, 9, 16, 25]
```

### Layer 3: The Pattern (5 minutes)
```python
# General form
[expression for item in iterable if condition]

# More examples
[x for x in range(10) if x % 2 == 0]      # [0, 2, 4, 6, 8]
[x.upper() for x in ['hello', 'world']]   # ['HELLO', 'WORLD']
```

### Layer 4: Deep Dive (15 minutes)
```python
# Nested comprehensions
matrix = [[i*j for j in range(3)] for i in range(3)]
# [[0, 0, 0], [0, 1, 2], [0, 2, 4]]

# With complex expressions
import math
data = [math.sqrt(x) for x in range(1, 11)]
```

### Layer 5: Edge Cases & Gotchas (10 minutes)
```python
# ⚠️ Mutable elements gotcha
[[0] * 3 for _ in range(3)]  # [[0,0,0], [0,0,0], [0,0,0]] ✓

# vs
[[0] * 3] * 3  # [[0,0,0], [0,0,0], [0,0,0]] - SAME OBJECT! ✗
```

---

## 4. CODE ALONG METHODOLOGY

### Before Code Along
- [ ] Learner has environment ready (IDE, REPL, notebook)
- [ ] Learner understands the goal of the exercise
- [ ] Code scaffold is prepared (or typed together)

### During Code Along
```
🎯 Teacher: "Type this exactly as I say..."
👨‍🎓 Student: Types character by character

🎯 Teacher: "Notice how I indented this..."
👨‍🎓 Student: Observes the pattern

🎯 Teacher: "What happens if we change x to y?"
👨‍🎓 Student: Predicts, then verifies
```

### After Code Along
- [ ] Run the code together
- [ ] Break it deliberately and debug together
- [ ] Ask "What would happen if..." questions
- [ ] Assign a small variation as exercise

---

## 5. SCAFFOLDING TECHNIQUES

### Scaffolding Levels

```
┌─────────────────────────────────────────────────────────┐
│                    SCAFFOLDING PYRAMID                   │
│                                                          │
│                         ▲                                │
│                        /│\                               │
│                       / │ \                              │
│                      /  │  \                             │
│                     /   │   \                            │
│                    /────│────\                          │
│                   /     │     \                         │
│                  /──────│──────\                        │
│                 /       │       \                       │
│                /────────│────────\                     │
│               /         │         \                    │
│              /──────────│──────────\                   │
│             /           │           \                  │
│            ▼────────────│───────────▼                   │
│         FULL SUPPORT     │      INDEPENDENT              │
│                        BASE                              │
└─────────────────────────────────────────────────────────┘
```

### Complete → Partial → Independent

```python
# Step 1: Complete (copy this exact code)
def greet(name: str) -> str:
    return f"Hello, {name}!"

# Step 2: Partial (fill in the blanks)
def greet(____: str) -> str:
    return f"____, {____}!"

# Step 3: Guided (choose from options)
greet(___)  # options: "Alice", 123, ["Bob"]

# Step 4: Independent (write from scratch)
# Write a function that takes a name and returns a greeting
```

---

## 6. ERROR TEACHING METHOD

### The "Deliberate Mistake" Technique

```python
# Teacher writes intentional error
numbers = [1, 2, 3, 4, 5]
squares = [x**2 in numbers]  # ← ERROR: 'in' instead of 'for'
#                         ^
# Student spots the error first!
```

### Error Categories for Teaching

| Error Type | Example | Teaching Point |
|------------|---------|---------------|
| **Syntax** | `[x for x]` | Missing colon, wrong brackets |
| **Logic** | `x**2 in nums` | Confusing operator precedence |
| **Type** | `[x for x in "123"]` | String vs list iteration |
| **Scope** | `x = 5; [x for x in range(3)]` | Loop variable shadowing |
| **Memory** | `[[0]*3]*3` | Shared references |

### Error Message Reading

```python
# Teach learners to read errors systematically
"""
Traceback (most recent call last):
  File "main.py", line 3, in <module>
    result = x ** 2 @ nums
              ~~~~~~^~~~~
SyntaxError: invalid syntax
         ^^^
         |
         └── This operator needs special syntax
"""
```

---

## 7. VISUAL TEACHING AIDS

### ASCII Diagrams

```
# How a list comprehension works:
input: [1, 2, 3, 4, 5]    [x**2 for x in items]
         │  │  │  │  │            │
         ▼  ▼  ▼  ▼  ▼            │
      ┌─────────────────┐          │
      │  OPERATION: x²  │          │
      └─────────────────┘          │
                │                  │
                ▼                  │
         [1, 4, 9, 16, 25] ◄───────┘
```

### State Visualization

```
# Before: [1, 2, 3, 4, 5]
# After:  [1, 4, 9, 16, 25]
#
# Step by step:
# ┌────────────────────────────────────┐
# │ x=1  →  x²=1  →  [1]             │
# │ x=2  →  x²=4  →  [1, 4]          │
# │ x=3  →  x²=9  →  [1, 4, 9]       │
# │ x=4  →  x²=16 →  [1, 4, 9, 16]   │
# │ x=5  →  x²=25 →  [1, 4, 9, 16, 25]│
# └────────────────────────────────────┘
```

---

## 8. PRACTICE EXERCISES DESIGN

### Exercise Types

| Type | Purpose | Example |
|------|---------|---------|
| **Warm-up** | Recall prerequisite knowledge | "What is a list in Python?" |
| **Guided** | Apply new concept with help | Fill in the blank exercises |
| **Practice** | Independent application | Transform loops to comprehensions |
| **Challenge** | Extend beyond taught content | Real-world problem solving |
| **Debug** | Find and fix errors | Given broken code, explain why |

### Exercise Difficulty Scaling

```
Easy:     "Double each number in [1, 2, 3]"
Medium:   "Filter odd numbers, then double evens"
Hard:     "Flatten a nested list using comprehension"
Expert:   "Implement a word frequency counter with comprehension"
```

---

## 9. KNOWLEDGE RETENTION TECHNIQUES

### Spaced Repetition in Code

```python
# Day 1: Learn it
[x**2 for x in range(5)]  # [0, 1, 4, 9, 16]

# Day 3: Review it
# What does this produce?
[x for x in range(10) if x % 2 == 0]

# Day 7: Apply it
# Transform this loop to comprehension:
result = []
for item in data:
    if item > 0:
        result.append(item * 2)

# Day 14: Teach it
# Explain comprehension to someone else
```

### Active Recall Questions

```python
# Instead of: "List comprehensions create lists"
# Ask: "What will this produce?"
[x for x in range(5) if x != 2]  # Answer before running!
```

---

## 10. ASSESSMENT METHODS

### Formative Assessment (During Learning)

| Technique | How | Purpose |
|-----------|-----|---------|
| **Think-Pair-Share** | Think → Partner → Class | Immediate feedback |
| **Exit Ticket** | 1 question at end | Check understanding |
| **Code Tracing** | Predict output | Mental model check |
| **Peer Review** | Review other's code | Different perspectives |

### Summative Assessment (After Learning)

```python
# Capstone Project Template
"""
Build a [real-world application] using [concept taught]

Requirements:
□ Must use [concept] in at least [N] places
□ Must handle [edge case]
□ Must include comments explaining [concept]

Rubric:
✓ Functional (40%)
✓ Code quality (30%)
✓ Use of [concept] (20%)
✓ Documentation (10%)
"""
```

---

*This file is part of Delegado OS - PROFESSOR Agent Mode*
