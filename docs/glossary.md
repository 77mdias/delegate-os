# 📖 Glossário — Delegado OS

> Termos, siglas e conceitos usados no sistema.

---

## A

**ADR** — Architecture Decision Record. Registro formal de uma decisão arquitetural com contexto, alternativas e consequências.

**Audit** — Auditoria per-class de compliance GRASP/GoF/SOLID. Comando: `/dos-hell:audit`.

---

## B

**BMAD** — Brainstorm → Method → Analysis → Deploy. Workflow de 4 fases para desenvolvimento estruturado.

**Briefing** — Primeira fase do workflow GSD. Entendimento completo da tarefa.

---

## C

**Controller** — Padrão GRASP. Separa lógica de interface da lógica de negócio. NUNCA coloque business logic em widgets/views.

**Coverage** — Percentual de código coberto por testes. Meta padrão: ≥80%.

---

## D

**Dark Analyst** — Personalidade do Delegado. Frio, analítico, direto, brutalmente honesto.

**Debt** — Dívida técnica. Código que funciona mas compromete manutenibilidade, performance ou segurança.

**DIP** — Dependency Inversion Principle. Dependa de abstrações, não de implementações concretas.

---

## E

**Expert** — Information Expert (GRASP). Atribua responsabilidade à classe que DETÉM os dados.

---

## F

**Factory** — GoF Creational Pattern. Centraliza criação de objetos. Variantes: Factory Method, Abstract Factory.

---

## G

**Gate** — Ponto de controle (milestone) que bloqueia progresso se critérios não são atendidos.

**GoF** — Gang of Four. 23 Design Patterns clássicos (Creational, Structural, Behavioral).

**GRASP** — General Responsibility Assignment Software Patterns. 9 princípios de atribuição de responsabilidade.

**GSD** — Get Shit Done. Workflow atômico: Briefing → Análise → Decomposição → Execução → Validação.

---

## H

**HELL Method** — Framework de desenvolvimento orientado a GRASP/GoF com TDD obrigatório e milestone gates. Fases: SPEC → TDD → REFACTOR → EVOLVE.

**HELL Logic Gate** — Processo de pensamento obrigatório antes de qualquer código: Information Expert → Pure Fabrication → Protected Variations → Indirection → Polymorphism.

**High Cohesion** — GRASP. Uma classe = Uma responsabilidade = Um motivo para mudar.

---

## I

**Indirection** — GRASP. Usar mediadores para desacoplar componentes.

**ISP** — Interface Segregation Principle. Interfaces granulares — nenhum client forçado a depender de métodos que não usa.

---

## L

**Low Coupling** — GRASP. Minimizar dependências entre módulos. Meta: ≤3 dependências diretas.

**LSP** — Liskov Substitution Principle. Subtipos substituem supertipos sem quebrar contratos.

---

## M

**Milestone** — Ponto de controle crucial em workflow. Tipos: M-SPEC, M-TEST, M-QUALITY, M-SHIP, M-REVIEW.

---

## O

**OCP** — Open/Closed Principle. Aberto para extensão, fechado para modificação.

**OpenSpec** — Workflow spec-driven: proposal → specs → design → tasks → implement.

---

## P

**Protected Variations** — GRASP. Identificar pontos de instabilidade e proteger com interfaces.

**Pure Fabrication** — GRASP. Criar abstrações que NÃO existem no domínio para manter coesão (ex: Repository, Service).

---

## R

**RED/GREEN/REFACTOR** — Ciclo TDD. RED: teste falha. GREEN: código mínimo passa. REFACTOR: limpar com padrões.

**Review** — Análise profunda do codebase com sugestão de features, novas specs e health score.

---

## S

**Skill** — Módulo autocontido com `SKILL.md`. Define uma capacidade do agent.

**SOLID** — SRP, OCP, LSP, ISP, DIP. 5 princípios de design orientado a objetos.

**SRP** — Single Responsibility Principle. Uma classe tem apenas um motivo para mudar.

**Strategy** — GoF Behavioral Pattern. Algoritmo intercambiável em runtime. Resolve conditional complexity.

---

## T

**TDD** — Test-Driven Development. Escrever teste ANTES do código. RED → GREEN → REFACTOR.

**Tech Debt** — Dívida técnica catalogada por severidade: 🔴 CRITICAL | 🟡 MAJOR | 🟢 MINOR | ⚪ TRIVIAL.

---

## U

**Ubiquitous Language** — Glossário compartilhado entre domínio e código. Todos usam os mesmos termos.

---

## V

**Verdict** — Resultado de um milestone gate: ✅ PASSED | ⚠️ CONDITIONAL | ❌ BLOCKED.

---

## W

**Workflow** — Pipeline de fases sequenciais para desenvolvimento. Ex: OpenSpec, BMAD, GSD, HELL.
