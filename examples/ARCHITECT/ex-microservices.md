# Example: Microservices Architecture with Delegado OS

## Scenario
Design a microservices-based e-commerce platform with the following bounded contexts:
- Catalog Management
- Order Processing
- Payment Gateway
- Inventory Tracking
- User Management

## Using ARCHITECT Mode

```bash
./delegado.sh architect "Design e-commerce microservices architecture"
```

## Architecture Decision: Event-Driven Pattern

### Domain Events
```
OrderCreated -> InventoryService, NotificationService
PaymentProcessed -> OrderService, NotificationService
StockUpdated -> CatalogService, OrderService
```

### GRASP Patterns Applied

| Pattern | Microservice | Usage |
|---------|-------------|-------|
| Controller | API Gateway | Request routing |
| Creator | OrderService | Creates Order entities |
| Expert | InventoryService | Manages stock expertise |
| Polymorphism | PaymentService | Multiple payment providers |
| Pure Fabrication | EventBus | Infrastructure concern |

### GoF Patterns in Infrastructure

- **Observer**: Event subscriptions
- **Strategy**: Payment provider selection
- **Factory**: Service instance creation
- **Proxy**: API gateway caching

## Service Contracts

### OrderService
```yaml
POST /orders
GET /orders/{id}
PUT /orders/{id}/status
DELETE /orders/{id}

Events Published: OrderCreated, OrderCancelled, OrderShipped
Events Consumed: PaymentProcessed, StockReserved
```

### InventoryService
```yaml
GET /inventory/{productId}
PUT /inventory/{productId}/reserve
PUT /inventory/{productId}/release

Events Published: StockUpdated, LowStockAlert
Events Consumed: OrderCreated, OrderCancelled
```

## Communication Patterns

| Service Pair | Pattern | Rationale |
|-------------|---------|-----------|
| Order → Inventory | Async/Event | Decoupling, eventual consistency |
| Order → Payment | Sync/REST | Transaction requirement |
| Notification → All | Async/Event | Fire-and-forget |

## Technology Stack Recommendation

- **API Gateway**: Kong or AWS API Gateway
- **Service Mesh**: Istio
- **Event Bus**: Apache Kafka
- **Service Discovery**: Consul
- **Database**: PostgreSQL per service
- **Monitoring**: Prometheus + Grafana
