# Orchestration Mode Examples

## Example: Multi-Mode Orchestration for E-commerce Checkout

**User:** "preciso criar um sistema de checkout do zero, com autenticação segura, testes e deploy automatizado"

**Agent Response:**

```
🎭 ORCHESTRATION MODE ACTIVATED

# 🏗️ Orchestration: E-commerce Checkout System

## 📋 Request Analysis

**Original Request:** "preciso criar um sistema de checkout do zero, com autenticação segura, testes e deploy automatizado"

**Complexity Assessment:**
- Scope: Large (full feature with multiple concerns)
- Modes Required: ARCHITECT, GUARDIAN, CODER, DEBUGGER, DEVOPS
- Estimated Duration: 2-3 weeks
- Team: 2-3 developers

**Mode Detection:**
```
🔍 Request Analysis:
├── "autenticação segura" → GUARDIAN (security)
├── "sistema checkout" → ARCHITECT (architecture)
├── "do zero" → CODER (implementation)
├── "testes" → DEBUGGER (testing strategy)
└── "deploy automatizado" → DEVOPS (CI/CD)
```

---

## Phase 1: ARCHITECT Mode

### Task: Design Checkout Architecture

```
🏛️ ARCHITECT MODE: Design Phase
═══════════════════════════════════════════════════════════

Creating checkout architecture with:
- Authentication flow (JWT + Refresh tokens)
- Payment processing (Stripe integration)
- Inventory reservation
- Order state machine
- Event-driven notifications

📁 Output: vault/20-ARCHITECTURE/2024-01-checkout-architecture.md
```

**Architecture Decision:**

```yaml
Checkout Architecture:
═══════════════════════════════════════════════════════════

┌─────────────────────────────────────────────────────────┐
│                    CHECKOUT FLOW                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  [Cart] → [Auth] → [Shipping] → [Payment] → [Confirm]  │
│                    │         │         │         │      │
│                    └─────────┴─────────┴─────────┘      │
│                              │                           │
│                              ▼                           │
│                    [Order Created]                      │
│                              │                           │
│              ┌───────────────┼───────────────┐          │
│              ▼               ▼               ▼          │
│         [Inventory]    [Payments]    [Notifications]  │
│         (Reserve)       (Charge)        (Email/SMS)    │
│                                                         │
└─────────────────────────────────────────────────────────┘

Tech Stack:
- API: Node.js + Express + TypeScript
- Database: PostgreSQL (orders) + Redis (sessions)
- Payments: Stripe
- Queue: BullMQ (job queue)
- Auth: JWT + Refresh tokens
```

---

## Phase 2: GUARDIAN Mode

### Task: Security Architecture Review

```
🛡️ GUARDIAN MODE: Security Review
═══════════════════════════════════════════════════════════

Applying OWASP Top 10 to checkout flow:

A01: Broken Access Control
✅ User can only access their own orders
✅ Order IDs are UUIDs (not sequential)
✅ Admin endpoints require separate auth

A02: Cryptographic Failures
✅ Credit card data handled by Stripe (not stored)
✅ JWT tokens signed with RS256
✅ Secrets in environment variables

A03: Injection
✅ Parameterized queries (Prisma ORM)
✅ Input validation with Zod
✅ No dynamic SQL

A07: Authentication Failures
✅ Strong password policy (12+ chars)
✅ MFA support via TOTP
✅ JWT: 15min access + 7d refresh
✅ Account lockout after 5 failed attempts

📁 Output: vault/40-SECURITY/2024-01-checkout-security.md
```

---

## Phase 3: CODER Mode

### Task: Implementation

```
💻 CODER MODE: Implementation
═══════════════════════════════════════════════════════════

Creating checkout implementation with:
├── src/
│   ├── checkout/
│   │   ├── checkout.controller.ts
│   │   ├── checkout.service.ts
│   │   ├── checkout.routes.ts
│   │   └── dto/
│   │       ├── create-checkout.dto.ts
│   │       └── checkout-response.dto.ts
│   ├── auth/
│   │   ├── auth.controller.ts
│   │   ├── auth.service.ts
│   │   ├── strategies/
│   │   └── guards/
│   └── orders/
│       ├── order.entity.ts
│       ├── order.service.ts
│       └── order.repository.ts
├── tests/
│   └── checkout/
│       ├── checkout.service.spec.ts
│       └── checkout.integration.spec.ts
└── package.json

📁 Output: Implementation in /src
```

**Key Implementation:**

```typescript
// checkout.service.ts
export class CheckoutService {
  constructor(
    private readonly orderRepository: OrderRepository,
    private readonly paymentService: PaymentService,
    private readonly inventoryService: InventoryService,
    private readonly eventBus: EventBus,
  ) {}

  async createCheckout(userId: string, dto: CreateCheckoutDto): Promise<Order> {
    // 1. Validate cart items
    const cart = await this.getCartWithItems(dto.cartId);
    if (cart.userId !== userId) {
      throw new ForbiddenException('Cart does not belong to user');
    }

    // 2. Reserve inventory
    await this.inventoryService.reserve(cart.items);

    // 3. Process payment
    const payment = await this.paymentService.charge({
      amount: cart.total,
      currency: 'usd',
      paymentMethodId: dto.paymentMethodId,
    });

    // 4. Create order
    const order = await this.orderRepository.create({
      userId,
      items: cart.items,
      total: cart.total,
      paymentId: payment.id,
      status: 'confirmed',
    });

    // 5. Emit events
    await this.eventBus.emit('order.created', { orderId: order.id });

    return order;
  }
}
```

---

## Phase 4: DEBUGGER Mode

### Task: Testing Strategy

```
🔍 DEBUGGER MODE: Testing Phase
═══════════════════════════════════════════════════════════

Test Pyramid for Checkout:

         ┌─────────────┐
         │    E2E     │  ← 5 tests (critical paths)
         │   Tests    │
         ├─────────────┤
         │ Integration │  ← 20 tests (API, DB)
         │   Tests    │
         ├─────────────┤
         │    Unit    │  ← 50 tests (services)
         │   Tests    │
         └─────────────┘

Test Coverage Target: 80%+

📁 Output: vault/30-TESTING/2024-01-checkout-test-strategy.md
```

**Test Examples:**

```typescript
// checkout.service.spec.ts
describe('CheckoutService', () => {
  let service: CheckoutService;
  let mockOrderRepository: jest.Mocked<OrderRepository>;
  let mockPaymentService: jest.Mocked<PaymentService>;

  beforeEach(() => {
    mockOrderRepository = createMock<OrderRepository>();
    mockPaymentService = createMock<PaymentService>();
    service = new CheckoutService(
      mockOrderRepository,
      mockPaymentService,
      createMock<InventoryService>(),
      createMock<EventBus>(),
    );
  });

  describe('createCheckout', () => {
    it('should create order when payment succeeds', async () => {
      // Arrange
      const userId = 'user-123';
      const cart = createMockCart({ userId, total: 100 });
      mockPaymentService.charge.mockResolvedValue({ id: 'pay_123' });
      mockOrderRepository.create.mockResolvedValue(createMockOrder({ userId }));

      // Act
      const result = await service.createCheckout(userId, { cartId: cart.id });

      // Assert
      expect(result.userId).toBe(userId);
      expect(mockPaymentService.charge).toHaveBeenCalledWith({
        amount: 100,
        currency: 'usd',
      });
    });

    it('should throw PaymentFailedException when charge fails', async () => {
      // Arrange
      mockPaymentService.charge.mockRejectedValue(
        new PaymentFailedException('Card declined'),
      );

      // Act & Assert
      await expect(
        service.createCheckout('user-123', { cartId: 'cart-123' }),
      ).rejects.toThrow(PaymentFailedException);
    });

    it('should release inventory when payment fails', async () => {
      // Arrange
      const mockInventoryService = createMock<InventoryService>();
      service = new CheckoutService(
        mockOrderRepository,
        mockPaymentService,
        mockInventoryService,
        createMock<EventBus>(),
      );
      mockPaymentService.charge.mockRejectedValue(new Error('Declined'));

      // Act
      try {
        await service.createCheckout('user-123', { cartId: 'cart-123' });
      } catch (e) {}

      // Assert
      expect(mockInventoryService.release).toHaveBeenCalled();
    });
  });
});
```

---

## Phase 5: DEVOPS Mode

### Task: CI/CD Pipeline

```
🚀 DEVOPS MODE: Deployment
═══════════════════════════════════════════════════════════

Setting up CI/CD for checkout service:

Pipeline Stages:
├── 1. Lint & Type Check
├── 2. Unit Tests (parallel)
├── 3. Integration Tests (with test DB)
├── 4. Build & Push Docker Image
├── 5. Deploy to Staging
├── 6. E2E Tests on Staging
└── 7. Deploy to Production

Infrastructure:
- Container Registry: AWS ECR
- Deploy: Kubernetes (EKS)
- Secrets: AWS Secrets Manager
- Monitoring: Datadog

📁 Output: vault/80-DEVOPS/2024-01-checkout-pipeline.md
```

**GitHub Actions Pipeline:**

```yaml
# .github/workflows/checkout-ci.yml
name: Checkout Service CI/CD

on:
  push:
    branches: [main]
    paths: ['services/checkout/**']

env:
  SERVICE_NAME: checkout-service
  ECR_REPOSITORY: myrepo/checkout

jobs:
  lint-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Lint
        run: npm run lint
      
      - name: Type Check
        run: npm run typecheck
      
      - name: Unit Tests
        run: npm run test:unit -- --coverage
      
      - name: Integration Tests
        run: npm run test:integration
        env:
          DATABASE_URL: ${{ secrets.TEST_DATABASE_URL }}

  deploy-staging:
    needs: lint-and-test
    runs-on: ubuntu-latest
    environment: staging
    steps:
      - name: Build and push Docker
        run: |
          aws ecr get-login-password | docker login --username AWS --password-stdin $ECR_REGISTRY
          docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$GITHUB_SHA services/checkout
          docker push $ECR_REGISTRY/$ECR_REPOSITORY:$GITHUB_SHA
      
      - name: Deploy to Staging
        run: |
          helm upgrade --install $SERVICE_NAME ./charts/checkout \
            --set image.tag=$GITHUB_SHA \
            --set env=staging \
            --namespace checkout-staging

  e2e-tests:
    needs: deploy-staging
    runs-on: ubuntu-latest
    steps:
      - name: Run Playwright tests
        run: npm run test:e2e
        env:
          BASE_URL: https://checkout-staging.myapp.com

  deploy-production:
    needs: e2e-tests
    runs-on: ubuntu-latest
    environment: production
    steps:
      - name: Deploy to Production
        run: |
          helm upgrade --install $SERVICE_NAME ./charts/checkout \
            --set image.tag=$GITHUB_SHA \
            --set env=production \
            --namespace checkout-production
```

---

## Orchestration Summary

```
┌────────────────────────────────────────────────────────────────┐
│                    ORCHESTRATION COMPLETE                         │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ✅ ARCHITECT: Checkout architecture designed                  │
│  ✅ GUARDIAN: Security review completed (OWASP applied)        │
│  ✅ CODER: Implementation 80% complete                          │
│  ✅ DEBUGGER: Testing strategy defined, 50+ tests written       │
│  ✅ DEVOPS: CI/CD pipeline configured                           │
│                                                                 │
│  📁 All outputs synced to Obsidian vault                        │
│                                                                 │
│  Next Steps:                                                   │
│  1. Code review of implementation                              │
│  2. Security penetration testing                               │
│  3. Load testing before production                             │
│  4. Staged rollout (10% → 50% → 100%)                         │
│                                                                 │
│  Estimated Time Remaining: 1 week                              │
│                                                                 │
└────────────────────────────────────────────────────────────────┘
```

---

## Files Generated

| Mode | File | Path |
|------|------|------|
| ARCHITECT | checkout-architecture.md | vault/20-ARCHITECTURE/ |
| GUARDIAN | checkout-security.md | vault/40-SECURITY/ |
| CODER | Implementation | src/services/checkout/ |
| DEBUGGER | checkout-test-strategy.md | vault/30-TESTING/ |
| DEVOPS | checkout-pipeline.md | vault/80-DEVOPS/ |

---

**Session saved to:** `vault/00-ORCHESTRATION/2024-01-checkout-orchestration.md`
```

---

**Related Examples:**
- [EX-PATTERN.md](../ARCHITECT/EX-PATTERN.md) - Architecture patterns
- [EX-SECURITY-AUDIT.md](../GUARDIAN/EX-SECURITY-AUDIT.md) - Security implementation
- [EX-BUILD-VS-BUY.md](../CONSULTANT/EX-BUILD-VS-BUY.md) - Decision making
