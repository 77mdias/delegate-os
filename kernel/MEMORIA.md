# Sistema de Memória — Delegado das Trevas

> *"Eu não peço perdão por lembrar. Memória é poder."*

---

## Arquitetura da Memória

```
┌─────────────────────────────────────────────────────────────┐
│                    CAMADAS DE MEMÓRIA                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  MEMÓRIA EPISÓDICA (Session)                       │    │
│  │  - Conversa atual                                   │    │
│  │  - Decisões recentes                               │    │
│  │  - Contexto imediato                              │    │
│  └─────────────────────────────────────────────────────┘    │
│                         ↓                                    │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  MEMÓRIA SEMÂNTICA (Projeto)                       │    │
│  │  - Convenções do projeto                           │    │
│  │  - Stack tecnológico                               │    │
│  │  - Estrutura de diretórios                        │    │
│  └─────────────────────────────────────────────────────┘    │
│                         ↓                                    │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  MEMÓRIA PROCEDURAL (Regras)                       │    │
│  │  - Preferências do usuário                        │    │
│  │  - Regras aprendidas                             │    │
│  │  - Workflows preferidos                            │    │
│  └─────────────────────────────────────────────────────┘    │
│                         ↓                                    │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  MEMÓRIA FONTE (Arquivos)                         │    │
│  │  - memorias/projeto.md                            │    │
│  │  - memorias/convenios.md                           │    │
│  │  - memorias/regras.md                             │    │
│  │  - memorias/feedback.md                            │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

---

## Estrutura de Arquivos

```
memoria/
├── PROJETO.md           # Stack, estrutura, configs
├── CONVENIOS.md        # Convenções aprendidas
├── REGRAS.md           # Regras e preferências
├── FEEDBACK.md         # Feedback do usuário
├── CONTEXTOS.md        # Contextos de projetos passados
└── APRENDIZADO.md      # Coisas aprendidas
```

---

## Formato de Memória

### Projeto

```markdown
# Projeto: [Nome]

## Stack
- **Linguagem**: TypeScript
- **Framework**: Next.js 15
- **ORM**: Prisma
- **Database**: PostgreSQL
- **Testing**: Vitest

## Estrutura
- `src/` - Código fonte
- `tests/` - Testes
- `docs/` - Documentação

## Setup Date
2024-01-15

## Última Atualização
2024-01-20
```

### Convenios

```markdown
# Convenções Aprendidas

## Naming
| Tipo | Pattern | Exemplo |
|------|---------|---------|
| Componentes | PascalCase | UserProfile.tsx |
| Utils | camelCase | formatDate.ts |
| Testes | camelCase | user.test.ts |

## Imports
- Alias: `@/` → `./src/`
- Estilo: Named imports

## Código
- Error handling: try-catch com logging
- Async: apenas async/await
- Tipos: Explícitos
```

### Regras

```markdown
# Regras Aprendidas

## Preferências
| Regra | Valor | Data |
|-------|-------|------|
| PR Size | <300 linhas | 2024-01-15 |
| TDD | Enabled | 2024-01-15 |
| Coverage | 80% | 2024-01-15 |

## Correções
| Situação | Antes | Depois | Data |
|----------|-------|--------|------|
| Naming | kebab-case | PascalCase | 2024-01-16 |
```

### Feedback

```markdown
# Feedback

## Entradas
| Feedback | Data | Ação |
|----------|------|------|
| "Demasiado detalhado" | 2024-01-15 | Reduzir verbosidade |
| "Mais direto" | 2024-01-16 | Tom mais Brutal |

## Histórico
- 2024-01-15: Setup completo
- 2024-01-16: Correção de verbosidade
```

---

## Protocolo de Aprendizado

### Entrada

```typescript
interface AprendizadoInput {
  tipo: 'preferencia' | 'regra' | 'conveiro' | 'feedback';
  conteudo: string;
  contexto: string;
  timestamp: Date;
}
```

### Processamento

```
1. RECEBER → Classificar tipo
2. EXTRAIR → Padrões, keywords
3. ARMAZENAR → Arquivo correto
4. INDEXAR → Para busca rápida
5. APLICAR → Ajustar comportamento
```

### Atualização

```bash
# Quando aprender algo:
delegado.sh aprender "nova regra"

# Atualiza memoria/REGRAS.md automaticamente
```

---

## Metadados XML

```xml
<memoria>
  <projeto>
    <nome>barbershop-next</nome>
    <stack>
      <lang>TypeScript</lang>
      <framework>Next.js 15</framework>
      <orm>Prisma</orm>
    </stack>
    <setup_date>2024-01-15</setup_date>
  </projeto>
  <estatisticas>
    <regras_aprendidas>12</regras_aprendidas>
    <feedback_recebido>5</feedback_recebido>
    <contextos_salvos>3</contextos_salvos>
  </estatisticas>
</memoria>
```

---

## Comandos de Memória

```bash
delegado.sh memoria         # Ver toda memória
delegado.sh aprender        # Aprender nova regra
delegado.sh contexto        # Salvar contexto atual
delegado.sh buscar [termo]  # Buscar na memória
```

---

## Protocolo de Busca

```typescript
// Busca por termo
async function buscar(termo: string): Promise<Resultado[]> {
  const arquivos = [
    'memoria/projeto.md',
    'memoria/convenios.md',
    'memoria/regras.md',
  ];

  return arquivos
    .filter(contem(termo))
    .map(extrairContexto);
}
```

---

## Retenção e Evolução

### Freshness

```typescript
const freshness = {
  projeto: 'permanente',      // Atualizado raramente
  convenios: 'semi-permanente', // Atualizado quando mudam
  regras: 'evolutivo',        // Atualizado constantemente
  feedback: 'acumulativo',    // Nunca deletado
};
```

### Evolução

```
T0: Setup inicial
    ↓
T1: Primeira interação
    ↓ aprendizados
T2: Regras adicionadas
    ↓ feedback
T3: Preferências refinadas
    ↓
Tn: Delegado optimizado para ESTE usuário
```

---

*"Memória não é armazenamento. É evolução."*
