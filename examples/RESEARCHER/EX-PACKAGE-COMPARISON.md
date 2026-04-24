# Researcher Mode Examples

## Example: Choosing a State Management Library for React

**User:** "qual a melhor biblioteca de state management para React em 2024? React Query vs Zustand vs Redux?"

**Agent Response:**

```
📡 RESEARCHER MODE ACTIVATED

# Research Report: React State Management (2024)

## Executive Summary

**Recommendation: Context-dependent**

- **Small-to-Medium apps:** Zustand (simplicity, bundle size)
- **Server state & caching:** TanStack Query (React Query)
- **Large enterprise apps:** Redux Toolkit (maturity, DevTools)
- **Minimalist approach:** Jotai (atomic, composable)

---

## 1. Problem Definition

```yaml
Context:
- React SPA with 50+ components
- Team of 4 developers
- Need to manage: UI state, server cache, form state
- Production app with 100k+ users
- Performance critical (mobile users)

Constraints:
- Bundle size < 200kb gzipped
- TypeScript required
- SSR support needed
- Time to implement: 2 weeks max
```

---

## 2. Options Analyzed

### Option A: Zustand

**Description:** Minimalist state management with hooks
**Website:** https://zustand.docs.pmnd.rs
**License:** MIT
**Last Release:** January 2024
**NPM Stats:** ⭐ 32k stars, 3.2M downloads/week

**Pros:**
- 🚀 Tiny bundle (1.1kb gzip)
- 📚 Simple API, easy learning curve
- 🔧 DevTools available
- ✅ TypeScript-first
- 🎯 No providers needed

**Cons:**
- ⚠️ No built-in server cache
- ⚠️ Less suited for complex async flows
- ⚠️ Smaller ecosystem than Redux

**Best For:** Apps with simple state needs, rapid prototyping

---

### Option B: TanStack Query (React Query)

**Description:** Async state management & server cache
**Website:** https://tanstack.com/query
**License:** MIT
**Last Release:** February 2024
**NPM Stats:** ⭐ 38k stars, 4.1M downloads/week

**Pros:**
- 🔄 Automatic caching & background refetching
- 📊 Optimistic updates built-in
- ⏱️ Stale-while-revalidate pattern
- 🔌 Works with any HTTP client
- 📱 Pagination & infinite scroll helpers

**Cons:**
- ⚠️ Server state only (not for UI state)
- ⚠️ Need separate solution for UI state
- ⚠️ Learning curve for cache invalidation

**Best For:** Data-heavy apps, dashboards, real-time updates

---

### Option C: Redux Toolkit

**Description:** Official Redux with modern best practices
**Website:** https://redux-toolkit.js.org
**License:** MIT
**Last Release:** January 2024
**NPM Stats:** ⭐ 23k stars, 5.8M downloads/week

**Pros:**
- ✅ Battle-tested (8+ years)
- 🔧 Excellent DevTools (Redux DevTools)
- 📚 Largest ecosystem & community
- 🏗️ Scalable architecture
- ✅ RTK Query (built-in server cache)

**Cons:**
- ⚠️ Larger bundle (~11kb gzip with DevTools)
- ⚠️ More boilerplate than Zustand
- ⚠️ Steeper learning curve

**Best For:** Large teams, enterprise apps, complex state logic

---

### Option D: Jotai

**Description:** Atomic state management
**Website:** https://jotai.org
**License:** MIT
**Last Release:** February 2024
**NPM Stats:** ⭐ 12k stars, 800k downloads/week

**Pros:**
- ⚛️ Atomic model (only re-render what changes)
- 🎯 Composable by design
- 🔌 Framework-agnostic (can use in React Native)
- 📦 Small bundle (2.3kb gzip)

**Cons:**
- ⚠️ Smaller community
- ⚠️ Less documentation than Redux
- ⚠️ Debugging can be harder

**Best For:** Complex derived state, highly optimized apps

---

## 3. Comparison Matrix

```
┌────────────────────────────────────────────────────────────────┐
│           COMPARISON MATRIX — React State Management            │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  CRITERIA          │ Zustand │ TanStack │ Redux  │ Jotai      │
│                    │         │ Query    │ Toolkit│            │
│  ────────────────────────────────────────────────────────────  │
│  Popularity         │  ⭐⭐⭐⭐   │  ⭐⭐⭐⭐⭐  │ ⭐⭐⭐⭐⭐│  ⭐⭐       │
│  Maintenance        │  ⭐⭐⭐⭐⭐  │  ⭐⭐⭐⭐⭐  │ ⭐⭐⭐⭐⭐│  ⭐⭐⭐⭐    │
│  Performance       │  ⭐⭐⭐⭐⭐  │  ⭐⭐⭐⭐   │ ⭐⭐⭐⭐ │  ⭐⭐⭐⭐⭐  │
│  Developer Exp     │  ⭐⭐⭐⭐⭐  │  ⭐⭐⭐⭐   │ ⭐⭐⭐  │  ⭐⭐⭐⭐    │
│  Documentation      │  ⭐⭐⭐⭐   │  ⭐⭐⭐⭐   │ ⭐⭐⭐⭐⭐│  ⭐⭐⭐     │
│  Bundle Size       │  1.1kb   │  13kb    │ 11kb   │  2.3kb    │
│  TypeScript        │  ✅      │  ✅      │  ✅    │  ✅       │
│  SSR Support       │  ✅      │  ✅      │  ✅    │  ✅       │
│  Server Cache      │  ❌      │  ✅      │  ✅*   │  ❌       │
│  ────────────────────────────────────────────────────────────  │
│  WEIGHTED SCORE    │   4.1   │   4.4   │  4.2   │  3.8       │
│                                                                 │
│  * = Redux Toolkit includes RTK Query                          │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

### Detailed Scoring (1-5)

| Criteria | Weight | Zustand | Query | Redux | Jotai |
|----------|--------|---------|-------|-------|-------|
| Popularity | 10% | 4 | 5 | 5 | 3 |
| Maintenance | 20% | 5 | 5 | 5 | 4 |
| Performance | 15% | 5 | 4 | 4 | 5 |
| DX | 15% | 5 | 4 | 3 | 4 |
| Docs | 15% | 4 | 4 | 5 | 3 |
| Bundle Size | 10% | 5 | 3 | 3 | 5 |
| TypeScript | 5% | 5 | 5 | 5 | 5 |
| SSR Support | 5% | 5 | 5 | 5 | 5 |
| Server Cache | 5% | 0 | 5 | 4 | 0 |
| **TOTAL** | 100% | **4.1** | **4.4** | **4.2** | **3.8** |

---

## 4. Recommendation

### For Your Context: **Hybrid Approach**

**🏆 Primary:** TanStack Query (server state) + Zustand (UI state)

**Rationale:**
1. You need server caching (API data)
2. You also need UI state (modals, themes, forms)
3. Team of 4 needs low learning curve
4. Bundle size is important

**Architecture:**
```
┌─────────────────────────────────────────────────────────┐
│                    React Application                     │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌─────────────────┐      ┌─────────────────┐         │
│  │   Zustand       │      │  TanStack Query │         │
│  │   (UI State)    │      │  (Server State) │         │
│  │                 │      │                 │         │
│  │ • Theme         │      │ • API data      │         │
│  │ • Sidebar       │      │ • Caching       │         │
│  │ • Modals        │      │ • Mutations     │         │
│  │ • User prefs    │      │ • Optimistic up │         │
│  │ • Forms         │      │                 │         │
│  └─────────────────┘      └─────────────────┘         │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

## 5. Integration Example

### Installation

```bash
# Zustand
npm install zustand

# TanStack Query
npm install @tanstack/react-query
```

### Zustand Store Example

```typescript
// stores/uiStore.ts
import { create } from 'zustand';
import { persist } from 'zustand/middleware';

interface UIState {
  theme: 'light' | 'dark';
  sidebarOpen: boolean;
  activeModal: string | null;
  setTheme: (theme: 'light' | 'dark') => void;
  toggleSidebar: () => void;
  openModal: (id: string) => void;
  closeModal: () => void;
}

export const useUIStore = create<UIState>()(
  persist(
    (set) => ({
      theme: 'light',
      sidebarOpen: true,
      activeModal: null,
      setTheme: (theme) => set({ theme }),
      toggleSidebar: () => set((s) => ({ sidebarOpen: !s.sidebarOpen })),
      openModal: (id) => set({ activeModal: id }),
      closeModal: () => set({ activeModal: null }),
    }),
    { name: 'ui-storage' }
  )
);
```

### TanStack Query Example

```typescript
// queries/useProducts.ts
import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import { api } from './api';

export function useProducts(category?: string) {
  return useQuery({
    queryKey: ['products', category],
    queryFn: () => api.getProducts(category),
    staleTime: 5 * 60 * 1000, // 5 minutes
  });
}

export function useCreateProduct() {
  const queryClient = useQueryClient();
  
  return useMutation({
    mutationFn: api.createProduct,
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['products'] });
    },
  });
}
```

### App Setup

```typescript
// App.tsx
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';

const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      retry: 2,
      staleTime: 1000 * 60 * 5, // 5 minutes
    },
  },
});

function App() {
  return (
    <QueryClientProvider client={queryClient}>
      <YourApp />
    </QueryClientProvider>
  );
}
```

---

## 6. When to Choose Each

| Scenario | Recommendation | Alternative |
|----------|----------------|-------------|
| Small app, simple state | Zustand only | Jotai |
| Data-heavy, lots of API calls | TanStack Query + Zustand | RTK Query |
| Enterprise, large team | Redux Toolkit | - |
| Need atomic updates | Jotai | Zustand |
| Real-time updates | TanStack Query + WebSockets | - |
| Offline-first | Zustand + IndexedDB | Redux Offline |

---

## 7. Migration Path

**From Redux to Zustand + Query:**
```bash
# Timeline: 2-3 sprints

Week 1:
- Install and configure TanStack Query
- Migrate one API domain to Query

Week 2:
- Migrate remaining API domains
- Start UI state migration to Zustand

Week 3:
- Complete Zustand migration
- Remove Redux packages
- Optimize bundle size
```

---

## 8. References

- [Zustand Docs](https://zustand.docs.pmnd.rs)
- [TanStack Query Docs](https://tanstack.com/query/latest)
- [State of React 2024 Survey](https://2024.stateofreact.com)
- [Bundlephobia Comparison](https://bundlephobia.com)

---

**Report saved to:** `vault/50-RESEARCH/2024-01-React-State-Management.md`
```

---

**Related Examples:**
- [EX-PATTERN.md](../ARCHITECT/EX-PATTERN.md) - Architecture decisions
- [EX-SECURITY-AUDIT.md](../GUARDIAN/EX-SECURITY-AUDIT.md) - Security considerations
