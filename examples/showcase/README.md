# Delegado OS Showcase

Demonstrates all operational modes of Delegado OS.

## Modes Overview

### 1. ARCHITECT Mode
Systems design and architecture planning using GRASP/GoF patterns.

```bash
./delegado.sh modo architect
```

**Use cases:**
- Microservices decomposition
- Event-driven architecture
- Domain-driven design

### 2. BACKLOG Mode
Task management and prioritization.

```bash
./delegado.sh modo backlog
```

**Use cases:**
- Sprint planning
- Technical debt tracking
- Feature prioritization

### 3. AUTONOMOUS Mode
Independent agent operation with self-directed execution.

```bash
./delegado.sh modo autonomous
```

**Use cases:**
- Unattended task completion
- Self-healing systems
- Proactive monitoring

### 4. RESEARCHER Mode
Deep investigation and comparative analysis.

```bash
./delegado.sh modo researcher
```

**Use cases:**
- Technology evaluation
- Performance benchmarking
- Database comparisons

### 5. CODE Mode
Implementation and refactoring focus.

```bash
./delegado.sh modo code
```

**Use cases:**
- Test-driven development
- Pattern implementation
- Code review automation

### 6. SHELL Mode
Terminal command orchestration.

```bash
./delegado.sh modo shell
```

**Use cases:**
- DevOps automation
- Deployment pipelines
- System administration

## Quick Start

```bash
# Run in autonomous mode
./delegado.sh autonomous "Implement user authentication"

# Run in architect mode
./delegado.sh architect "Design a real-time chat system"

# Run in researcher mode
./delegado.sh researcher "Compare PostgreSQL vs MongoDB for analytics"
```

## Example Outputs

Each mode produces structured artifacts in the `memory/` directory:
- Architecture diagrams (Mermaid format)
- Technical specifications (Markdown)
- Analysis reports
- Implementation plans
