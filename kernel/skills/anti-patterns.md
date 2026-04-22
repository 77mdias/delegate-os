# Reference: Anti-Patterns

## Code Anti-Patterns

### God Object
- Single class doing too much
- Fix: Single Responsibility, extract

### Primitive Obsession
- Overusing primitives instead of types
- Fix: Value objects for domain concepts

### Shotgun Surgery
- One change requires many scattered changes
- Fix: Extract abstraction

### Data Clumps
- Same fields appearing together
- Fix: Extract shared object

## Architecture Anti-Patterns

### Anemic Domain
- Objects with no business logic
- Fix: Move logic from services to domain

### Coupling to Implementation
- Depending on concrete classes
- Fix: Depend on interfaces

### Premature Optimization
- Optimizing before measurement
- Fix: Profile first

## Testing Anti-Patterns

### Test Logic Duplication
- Test code mirrors app code
- Fix: Test behavior, not implementation

### Brittle Tests
- Tests break from unrelated changes
- Fix: Test outcomes, not details

### Ignoring Failures
- Pushing with failing tests
- Fix: Never commit with failing tests
