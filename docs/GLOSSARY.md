# 📖 Delegado OS — Glossary

> Complete glossary of terms, acronyms, and concepts used in Delegado OS.

---

## A

**ADR** — Architecture Decision Record. Formal record of an architectural decision including context, alternatives, and consequences.

**Agent Mode** — A specialized operating mode for the Delegado agent with specific capabilities, personality, and tools. See `AGENT-MODES.md`.

**API** — Application Programming Interface. Contract for interaction between software components.

**Audit** — Per-class compliance audit against GRASP/GoF/SOLID patterns. Command: `/dos-hell:audit`.

---

## B

**BMAD** — Brainstorm → Method → Analysis → Deploy. 4-phase structured development workflow.

**Briefing** — First phase of the GSD workflow. Complete understanding of the task before execution begins.

---

## C

**Callback** — Hook script triggered by a plugin lifecycle event (e.g., `pre_secret_access`, `post_deploy`).

**CLI** — Command-Line Interface. The `delegado.sh` script provides the main CLI for Delegado OS.

**Cohesion** — Degree to which elements inside a module belong together. High cohesion = single responsibility.

**Container** — Lightweight, isolated execution environment (Docker/Podman). Plugin: `plugins/container`.

**Context** — Current state, conversation history, project files, and environment variables passed to the agent.

**Controller** — GRASP pattern. Separates interface logic from business logic. Never put business logic in widgets/views.

**Coverage** — Percentage of code covered by tests. Default target: ≥80%.

**Coupling** — Degree of interdependence between modules. Low coupling = minimal dependencies.

---

## D

**Dark Analyst** — Delegado personality. Cold, analytical, direct, brutally honest.

**Debt** — Technical debt. Code that works but compromises maintainability, performance, or security.

**Delegado OS** — Agent Operating System. Multi-agent orchestration framework with meta-prompting intelligence layer.

**Dependency Injection** — Technique where dependencies are passed as parameters rather than created internally.

**DIP** — Dependency Inversion Principle. Depend on abstractions, not concrete implementations.

**Docker** — Container runtime. Supported by the `container` plugin.

**Domain** — Problem space. The business area being modeled by the software.

---

## E

**Expert** — Information Expert (GRASP). Assign responsibility to the class that OWNS the data.

---

## F

**Factory** — GoF Creational Pattern. Centralizes object creation. Variants: Factory Method, Abstract Factory.

**FAQ** — Frequently Asked Questions. Common questions and answers for quick reference.

---

## G

**Gate** — Control point (milestone) that blocks progress if criteria are not met.

**Git Hook** — Script that runs automatically during Git operations (pre-commit, post-merge, etc.).

**GoF** — Gang of Four. 23 classic Design Patterns (Creational, Structural, Behavioral).

**GRASP** — General Responsibility Assignment Software Patterns. 9 principles for responsibility assignment.

**GSD** — Get Shit Done. Atomic workflow: Briefing → Analysis → Decomposition → Execution → Validation.

---

## H

**HELL Method** — Development framework oriented to GRASP/GoF with mandatory TDD and milestone gates. Phases: SPEC → TDD → REFACTOR → EVOLVE.

**HELL Logic Gate** — Mandatory thought process before any code: Information Expert → Pure Fabrication → Protected Variations → Indirection → Polymorphism.

**High Cohesion** — GRASP. One class = One responsibility = One reason to change.

**Hook** — Plugin callback script triggered at specific lifecycle events. Defined in plugin `manifest.yaml`.

---

## I

**Indirection** — GRASP. Use mediators to decouple components.

**ISP** — Interface Segregation Principle. Granular interfaces — no client forced to depend on unused methods.

---

## K

**K8s** — Kubernetes. Container orchestration platform. Plugin: `plugins/kubernetes`.

**Kubernetes** — Open-source container orchestration system for automating deployment, scaling, and management.

---

## L

**Learning Path** — Structured curriculum for learning a specific topic. Stored in `templates/learning-paths/`.

**Low Coupling** — GRASP. Minimize dependencies between modules. Target: ≤3 direct dependencies.

**LSP** — Liskov Substitution Principle. Subtypes replace supertypes without breaking contracts.

---

## M

**Manifest** — YAML file defining a plugin's metadata, hooks, and configuration. E.g., `plugins/container/manifest.yaml`.

**Meta-Prompting** — Intelligence layer that optimizes agent prompts based on context, mode, and learned patterns.

**Milestone** — Critical control point in a workflow. Types: M-SPEC, M-TEST, M-QUALITY, M-SHIP, M-REVIEW.

**Mode Orchestrator** — Component that automatically selects the appropriate agent mode based on context.

---

## N

**Namespace** — Kubernetes concept for resource isolation. Default: `delegado`.

---

## O

**OCP** — Open/Closed Principle. Open for extension, closed for modification.

**OpenSpec** — Spec-driven workflow: proposal → specs → design → tasks → implement.

**Orchestration** — Coordination of multiple agents or services to accomplish a task.

---

## P

**Pattern** — Reusable solution to a recurring problem. See GoF, GRASP, SOLID.

**Plugin** — Extensible module that adds capabilities to Delegado OS. Defined by `manifest.yaml` + hooks.

**Polymorphism** — GRASP. Ability to treat objects of different types uniformly through a common interface.

**Protected Variations** — GRASP. Identify points of instability and protect with interfaces.

**Pure Fabrication** — GRASP. Create abstractions that do NOT exist in the domain to maintain cohesion (e.g., Repository, Service).

---

## Q

**Quick Reference** — Single-page summary of all modes and their key commands.

---

## R

**RED/GREEN/REFACTOR** — TDD cycle. RED: test fails. GREEN: minimal code passes. REFACTOR: clean up with patterns.

**Review** — Deep analysis of codebase with feature suggestions, new specs, and health score.

---

## S

**Secret** — Sensitive credential (API key, password, token) managed by the `secret-manager` plugin.

**Skill** — Self-contained module with `SKILL.md`. Defines a capability the agent can perform.

**SOLID** — SRP, OCP, LSP, ISP, DIP. Five object-oriented design principles.

**Spike** — Time-boxed research task to investigate a technology or approach before full implementation.

**SRP** — Single Responsibility Principle. A class has only one reason to change.

**Strategy** — GoF Behavioral Pattern. Interchangeable algorithm at runtime. Resolves conditional complexity.

---

## T

**TDD** — Test-Driven Development. Write test BEFORE code. RED → GREEN → REFACTOR.

**Tech Debt** — Technical debt cataloged by severity: 🔴 CRITICAL | 🟡 MAJOR | 🟢 MINOR | ⚪ TRIVIAL.

**Template** — Starter document for creating artifacts (specs, PRDs, learning paths). Stored in `templates/`.

**Terraform** — Infrastructure as Code tool. Can be used with Kubernetes plugin.

**Trace** — Record of request execution across services. Used for debugging distributed systems.

---

## U

**Ubiquitous Language** — Shared glossary between domain and code. Everyone uses the same terms.

---

## V

**Verdict** — Result of a milestone gate: ✅ PASSED | ⚠️ CONDITIONAL | ❌ BLOCKED.

**Vault** — HashiCorp Vault. Secret management system supported by `secret-manager` plugin.

---

## W

**Webhook** — HTTP callback triggered by events. Used by `webhook` plugin for event-driven automation.

**Workflow** — Sequential pipeline for development. Examples: OpenSpec, BMAD, GSD, HELL.

---

## Y

**YAML** — YAML Ain't Markup Language. Human-readable data serialization format used for configs and manifests.
