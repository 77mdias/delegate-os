# Architect Mode Examples

## Example: Choosing Between REST and GraphQL

**User:** "preciso expor dados para um app mobile, devo usar REST ou GraphQL?"

**Agent Response:**

```
🏛️ ARCHITECT MODE ACTIVATED

# Arquitetura de API: REST vs GraphQL

## Contexto

- **App Mobile** (iOS + Android)
- **Time:** 3 devs mobile, 2 devs backend
- **Data:** Usuários, Produtos, Pedidos, Notificações
- **Scale:** ~50k DAU (Daily Active Users)

## Análise Comparativa

```
┌─────────────────────────────────────────────────────────────┐
│                    COMPARISON MATRIX                         │
├─────────────────┬───────────────────┬───────────────────────┤
│    Criteria     │      REST         │       GraphQL          │
├─────────────────┼───────────────────┼───────────────────────┤
│ Learning Curve  │ ⭐⭐⭐⭐⭐ (Easy)   │ ⭐⭐⭐ (Medium)        │
│ Flexibility     │ ⭐⭐⭐ (Fixed)     │ ⭐⭐⭐⭐⭐ (Flexible)  │
│ Over-fetching  │ ❌ Comum           │ ✅ Evitado             │
│ Under-fetching │ ⚠️ Múltiplas req │ ✅ Uma req             │
│ Tooling        │ ⭐⭐⭐⭐⭐ Mature   │ ⭐⭐⭐⭐ Growing      │
│ Caching        │ ⭐⭐⭐⭐⭐ Native   │ ⭐⭐⭐ Extra effort   │
│ Mobile Perf    │ ⭐⭐⭐ (Multiple)  │ ⭐⭐⭐⭐⭐ (One shot) │
└─────────────────┴───────────────────┴───────────────────────┘
```

## Cenário Específico: Mobile App

### 🚀 REST Approach

```yaml
# Endpoints:
GET /api/users/{id}
GET /api/users/{id}/orders
GET /api/users/{id}/notifications
GET /api/products/{id}

# Mobile Code:
user = api.get("/users/123")
orders = api.get("/users/123/orders")
notifs = api.get("/users/123/notifications")
# 3 requests round-trip
```

### ⚡ GraphQL Approach

```yaml
# Schema:
type User {
  id: ID!
  name: String!
  orders: [Order!]!
  notifications: [Notification!]!
}

# Mobile Query:
query UserDashboard($userId: ID!) {
  user(id: $userId) {
    name
    orders(last: 5) {
      id
      total
      date
    }
    notifications(unread: true) {
      id
      message
    }
  }
}

# Single request!
```

## 🎯 Recomendação

### Para o seu caso específico: **GraphQL**

**Razões:**

1. **Mobileperf** - Uma única requisição para dashboard completo
2. **Flexibilidade** - Mobile pode evoluir sem backend
3. **Menos código** - Sem mapeamento de múltiplos endpoints
4. **Type Safety** - Geração automática de tipos

### Quando escolher REST:

- Microsserviços simples
- Necessidade de cache HTTP nativo
- Times sem experiência GraphQL
- APIS públicas/terceiros

## 🔧 Stack Recomendada

```yaml
# Backend:
- Apollo Server (Node.js/Go/Python)
- PostgreSQL + Prisma
- Redis for caching

# Mobile:
- Apollo Client (iOS + Android)
- Type-safe generated code
```

## 📊 Decision Tree

```
Precisa expor API?
│
├─ SIM ──────────────────────────────┐
│                                     │
│ Mobile-first? ── SIM ──► GraphQL  │
│                                     │
│ Simples/CRUD? ── SIM ──► REST     │
│                                     │
│ Microsserviços? ── SIM ──► REST   │
│                                     │
│ BI/Analytics? ── SIM ──► REST      │
│
└─ NÃO
  └─► GraphQL (mobile app)
```

---

*Saved to:* `vault/20-ARCHITECTURE/2024-01-REST-vs-GraphQL.md`
