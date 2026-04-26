---
last-updated: "{{YYYY-MM-DD}}"
---

# 🧩 Padrões Aprendidos

Este documento registra padrões e abordagens aprendidas pelo agente durante execuções.

---

## Padrões de Execução

### Criar Phase Board
```
1. Copy template: cp skills/dos/hell/phase_board/templates/tasks/phase-board.template.md docs/development/PHASES/PHASE-XX/phase-board.md
2. Fill frontmatter (title, type, status, version, phase-number)
3. Create categories based on domains
4. Add tasks with IDs (PHASE-XX-CAT-001)
5. Update progress table
6. Update README/ROADMAP
```

### Invocar Skill
```
1. Read skill file to understand context
2. Follow skill's <process> section
3. Report using skill's <output format>
4. Update memory if needed
```

### Executar Tarefa Complexa
```
1. Decompose into subtasks
2. Execute subtasks in order
3. Validate each step
4. Create checkpoint before dangerous ops
5. Update active-context.md
6. Report completion
```

---

## Armadilhas Conhecidas

### Git
- ❌ Nunca fazer `push --force` sem checkpoint
- ❌ Nunca fazer `reset --hard` sem backup
- ⚠️ Sempre verificar `git status` antes de merge

### Arquivos
- ❌ Nunca sobrescrever sem backup
- ❌ Nunca deletar sem confirmar
- ⚠️ Manter `.gitignore` atualizado

### Skills
- ⚠️ Algumas skills podem ter dependências circulares
- ⚠️ Verificar se skill existe antes de invocar
- ✅ Fallback: fazer manualmente se skill falhar

---

## Decisões Arquiteturais

### Phase Board
- Tasks devem ter IDs únicos (PHASE-XX-CAT-001)
- Status: 🔴 Pendente | 🚧 Em progresso | ✅ Concluído | ⛔ Bloqueada
- Prioridade: 🔴 Crítica | 🟡 Alta | 🟢 Média | 🔵 Baixa

### Documentation
- Frontmatter: title, type, status, last-updated (mínimo)
- Timestamps: YYYY-MM-DD ou YYYY-MM-DD HH:MM
- Status emoji: 🟢 Ativa | 🔵 Planejada | ⚪ Arquivada

### Git Commits
- Formato: `type(scope): description`
- Types: feat, fix, docs, refactor, test, chore
- Commits atômicos (uma mudança por commit)

---

## Workflows Aprendidos

### Bug Fix
```
1. Reproduzir bug
2. Criar teste que falha
3. Identificar causa
4. Corrigir
5. Verificar teste passa
6. Atualizar CHANGELOG
```

### Nova Feature
```
1. Criar/actualizar SPEC
2. Criar phase board se necessário
3. Implementar com TDD
4. Testar manually
5. Update docs
6. Commit
```

### Code Review
```
1. Run tests
2. Check style/format
3. Verify security
4. Check performance
5. Report findings
```
