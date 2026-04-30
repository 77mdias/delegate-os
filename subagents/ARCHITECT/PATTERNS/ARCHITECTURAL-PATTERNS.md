# Architectural Patterns Guide

> Collection of proven architectural patterns for system design.

## Categories

### 1. CREATIONAL PATTERNS (Object Creation)

| Pattern | Intent | Use Case |
|---------|--------|----------|
| **Singleton** | Single instance | Config, DB connection, Logger |
| **Factory Method** | Subclass decides class | Plugin systems, Drivers |
| **Abstract Factory** | Family of related objects | Cross-platform UI, Multi-DB |
| **Builder** | Step-by-step construction | Complex objects, Query builders |
| **Prototype** | Clone existing object | Caching, Undo mechanisms |

### 2. STRUCTURAL PATTERNS (Object Composition)

| Pattern | Intent | Use Case |
|---------|--------|----------|
| **Adapter** | Interface compatibility | Legacy code integration |
| **Bridge** | Decouple abstraction from impl | Cross-platform apps |
| **Composite** | Tree structures | UI components, File systems |
| **Decorator** | Add behavior dynamically | Logging, Caching, Validation |
| **Facade** | Simplified interface | Library wrappers, Service layers |
| **Flyweight** | Share common state | Text editors, Game objects |
| **Proxy** | Controlled access | Lazy loading, Access control |

### 3. BEHAVIORAL PATTERNS (Object Interaction)

| Pattern | Intent | Use Case |
|---------|--------|----------|
| **Chain of Responsibility** | Pass request along chain | Middleware, Event handling |
| **Command** | Encapsulate operation as object | Undo/Redo, Queuing |
| **Iterator** | Sequential access | Collections, Database cursors |
| **Mediator** | Centralized communication | UI controllers, Chat rooms |
| **Memento** | Capture state externally | Undo, Snapshots, Transactions |
| **Observer** | Notify dependents | Event systems, Data binding |
| **State** | Alter behavior based on state | FSM, Order processing |
| **Strategy** | Interchangeable algorithms | Sorting, Compression, Auth |
| **Template Method** | Algorithm skeleton | Frameworks, Data processing |
| **Visitor** | Separate algorithm from structure | AST traversal, Report generation |

### 4. ENTERPRISE PATTERNS

| Pattern | Intent | Use Case |
|---------|--------|----------|
| **Domain-Driven Design** | Align model with domain | Complex business logic |
| **CQRS** | Separate read/write | High-throughput systems |
| **Event Sourcing** | Store events, not state | Audit trails, Temporal queries |
| **Saga** | Distributed transactions | Microservices, Choreography |
| **Circuit Breaker** | Fault tolerance | External service calls |
| **Bulkhead** | Isolate failures | Microservices |
| **Retry** | Transient failure handling | Network calls, APIs |

### 5. ARCHITECTURAL STYLES

```
┌─────────────────────────────────────────────────────────────┐
│                    ARCHITECTURAL STYLES                     │
├──────────────┬───────────────┬──────────────┬──────────────┤
│   MONOLITHIC │   LAYERED     │    MICROSER- │    EVENT-    │
│              │               │    VICES     │    DRIVEN    │
├──────────────┼───────────────┼──────────────┼──────────────┤
│ All in one   │ Separation    │ Small, inde- │ Async events │
│ deployable   │ by concern    │ pendent      │ decouple     │
│              │               │ services     │ components   │
└──────────────┴───────────────┴──────────────┴──────────────┘
```

### 6. API DESIGN PATTERNS

| Pattern | Description |
|---------|-------------|
| **REST** | Resource-based, stateless |
| **GraphQL** | Query what you need |
| **gRPC** | High-performance, binary |
| **WebSocket** | Real-time, bidirectional |
| **Webhook** | Event-driven callbacks |
| **Webhook → Saga** | Choreography |
| **API Gateway** | Single entry point |

### 7. DATABASE PATTERNS

| Pattern | Use Case |
|---------|----------|
| **Repository** | Abstract data access |
| **Unit of Work** | Atomic operations |
| **Data Mapper** | ORM pattern |
| **Identity Map** | Avoid duplicate objects |
| **Lazy Loading** | Defer loading |
| **Eager Loading** | Pre-fetch related |

### 8. OBSERVER PATTERNS IMPLEMENTATION

```python
# Pattern: Observer (Pub/Sub)
class EventBus:
    """Central event dispatcher"""
    
    def __init__(self):
        self._subscribers: Dict[str, List[Callable]] = defaultdict(list)
    
    def subscribe(self, event: str, handler: Callable) -> None:
        """Subscribe to an event"""
        self._subscribers[event].append(handler)
    
    def unsubscribe(self, event: str, handler: Callable) -> None:
        """Unsubscribe from an event"""
        self._subscribers[event].remove(handler)
    
    def emit(self, event: str, data: Any = None) -> None:
        """Emit an event to all subscribers"""
        for handler in self._subscribers[event]:
            handler(data)


# Usage
event_bus = EventBus()

def on_user_created(user):
    send_welcome_email(user)
    setup_user_permissions(user)
    create_user_audit_log(user)

event_bus.subscribe("user.created", on_user_created)
event_bus.emit("user.created", new_user)
```

### 9. DECORATOR PATTERNS

```python
# Pattern: Decorator (cross-cutting concerns)
from functools import wraps
from typing import Callable
import time
import logging

def with_logging(func: Callable) -> Callable:
    """Decorator to add logging"""
    @wraps(func)
    def wrapper(*args, **kwargs):
        logging.info(f"Calling {func.__name__}")
        result = func(*args, **kwargs)
        logging.info(f"{func.__name__} completed")
        return result
    return wrapper

def with_timing(func: Callable) -> Callable:
    """Decorator to measure execution time"""
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        elapsed = time.time() - start
        logging.info(f"{func.__name__} took {elapsed:.2f}s")
        return result
    return wrapper

def with_retry(max_attempts: int = 3, delay: float = 1.0):
    """Decorator to retry on failure"""
    def decorator(func: Callable) -> Callable:
        @wraps(func)
        def wrapper(*args, **kwargs):
            for attempt in range(max_attempts):
                try:
                    return func(*args, **kwargs)
                except Exception as e:
                    if attempt == max_attempts - 1:
                        raise
                    logging.warning(f"{func.__name__} failed, retrying...")
                    time.sleep(delay)
        return wrapper
    return decorator


# Chaining decorators
@with_logging
@with_timing
@with_retry(max_attempts=3)
def fetch_data(endpoint: str):
    """Fetch data from API with full instrumentation"""
    return api.get(endpoint)
```

### 10. STRATEGY PATTERNS

```python
from abc import ABC, abstractmethod
from typing import Dict

# Strategy Interface
class SortStrategy(ABC):
    @abstractmethod
    def sort(self, data: List) -> List:
        pass

# Concrete Strategies
class QuickSort(SortStrategy):
    def sort(self, data: List) -> List:
        # Quick sort implementation
        return sorted(data)

class MergeSort(SortStrategy):
    def sort(self, data: List) -> List:
        # Merge sort implementation
        return sorted(data)

class HeapSort(SortStrategy):
    def sort(self, data: List) -> List:
        # Heap sort implementation
        return sorted(data)

# Context
class Sorter:
    def __init__(self, strategy: SortStrategy):
        self._strategy = strategy
    
    def set_strategy(self, strategy: SortStrategy):
        self._strategy = strategy
    
    def execute(self, data: List) -> List:
        return self._strategy.sort(data)


# Usage
sorter = Sorter(QuickSort())
sorter.execute(data)

# Change strategy at runtime
sorter.set_strategy(MergeSort())
```

## Pattern Selection Matrix

```
┌────────────────────────┬──────────────────────────────────┐
│      SITUATION         │          RECOMMENDED PATTERN     │
├────────────────────────┼──────────────────────────────────┤
│ Need single instance   │ Singleton                        │
│ Build complex objects  │ Builder                          │
│ Integrate legacy code  │ Adapter                          │
│ Add behavior at runtime│ Decorator                        │
│ Simplify complex system│ Facade                          │
│ Manage object lifecycle│ Factory/Abstract Factory         │
│ Coordinate components  │ Mediator                         │
│ Track state changes    │ Observer/Memento                 │
│ Define algorithms      │ Strategy/Template Method         │
│ Process requests chain │ Chain of Responsibility           │
│ Work with tree structures│ Composite                      │
│ Optimize memory        │ Flyweight                        │
│ Control access         │ Proxy                           │
│ Handle distributed tx  │ Saga                             │
│ Implement event system │ Observer + Mediator              │
└────────────────────────┴──────────────────────────────────┘
```

## GRASP Patterns (General Responsibility Assignment Software Patterns)

| Pattern | Description |
|---------|-------------|
| **Information Expert** | Assign responsibility to class with needed info |
| **Creator** | Create objects you use or contain |
| **Controller** | Handle system events, delegate to other objects |
| **Low Coupling** | Minimize dependencies between classes |
| **High Cohesion** | Keep related responsibilities together |
| **Polymorphism** | Handle variations based on type |
| **Pure Fabrication** | Create class to achieve low coupling/high cohesion |
| **Indirection** | Introduce intermediary to decouple |
| **Protected Variations** | Isolate unstable elements behind stable interfaces |

---

*This file is part of Delegado OS - ARCHITECT Agent Mode*
