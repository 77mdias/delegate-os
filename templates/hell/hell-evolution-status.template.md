---
title: "HELL Evolution Status: {{project}}"
type: hell-evolution
mode: tracking
status: draft
version: 1.0.0
author: "{{author}}"
date: "{{date}}"
---

# 💀 HELL Evolution Status: {{PROJECT}}

```yaml
Project: "[[{{PROJECT}}]]"
HELL_Phase: Evolution
HELL_Gate: PENDING
Status: 🔥 ACTIVE
```

---

## 1. CI/CD Pipeline Status

| Stage | Tool | Config File | Status | Threshold |
|:------|:-----|:-----------|:-------|:----------|
| Lint | | | ✅ / ❌ / ⬜ N/A | Zero warnings |
| Format | | | ✅ / ❌ / ⬜ N/A | Auto-fixed |
| Test | | | ✅ / ❌ / ⬜ N/A | Coverage ≥80% |
| Build | | | ✅ / ❌ / ⬜ N/A | <30s |
| Deploy (staging) | | | ✅ / ❌ / ⬜ N/A | Zero-downtime |
| Deploy (prod) | | | ✅ / ❌ / ⬜ N/A | Zero-downtime |

### Missing Stages

| Stage | Recommendation | Priority | Effort |
|:------|:-------------- |:---------|:-------|
| | | HIGH / MED / LOW | S / M / L |

### Pre-commit Hooks

| Hook | Installed? | Command |
|:-----|:-----------|:--------|
| Lint | ✅ / ❌ | |
| Format | ✅ / ❌ | |
| Tests | ✅ / ❌ | |
| Commit msg | ✅ / ❌ | |

---

## 2. Quality Gates

| Gate | Metric | Current | Target | Status |
|:-----|:-------|:--------|:-------|:-------|
| Coverage | Lines % | | ≥80% | ✅ / ❌ |
| Coverage | Branches % | | ≥70% | ✅ / ❌ |
| Complexity | Avg cyclomatic | | ≤10 | ✅ / ❌ |
| Duplication | % | | ≤5% | ✅ / ❌ |
| Vulnerabilities | Count | | 0 critical | ✅ / ❌ |

---

## 3. Documentation Status

| Document | Location | Last Updated | Status |
|:---------|:---------|:-------------|:-------|
| README.md | `./README.md` | | ✅ / ❌ stale |
| CHANGELOG.md | `./CHANGELOG.md` | | ✅ / ❌ / ⬜ missing |
| API Docs | | | ✅ / ❌ / ⬜ missing |
| Architecture Docs | | | ✅ / ❌ / ⬜ missing |
| ADRs | `changes/*/` | | ✅ / ❌ / ⬜ missing |

---

## 4. Monitoring & Observability

| Component | Tool | Status | Config |
|:----------|:-----|:-------|:-------|
| Error Tracking | | ✅ / ❌ / ⬜ N/A | |
| APM | | ✅ / ❌ / ⬜ N/A | |
| Logging | | ✅ / ❌ / ⬜ N/A | |
| Alerting | | ✅ / ❌ / ⬜ N/A | |
| Health Check | | ✅ / ❌ / ⬜ N/A | |

---

## 5. Gate M-SHIP — Checklist

- [ ] CI/CD pipeline exists and is green
- [ ] Zero critical vulnerabilities
- [ ] Tech debt cataloged in `memory/hell-tech-debt.md`
- [ ] Documentation 100% synced
- [ ] Breaking changes documented
- [ ] Review completed (`/dos-hell:review`)
- [ ] Monitoring configured (if applicable)

**Gate Status:** ⬜ PENDING | ✅ PASSED | ❌ BLOCKED

---

## 6. Próximo Passo

→ Gate M-SHIP aprovado → Deploy + Feedback Loop → `/dos-hell:review`
