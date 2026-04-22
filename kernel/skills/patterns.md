# Reference: Universal Patterns

## Feature Delivery

```
1. Contract/Schema First
2. Failing Test
3. Minimal Implementation
4. Refactor
5. Verify
```

## TDD Cycle

```
Red (failing test) → Green (pass) → Refactor → Repeat
```

## Layer Architecture (Stack-Agnostic)

```
Client → Validation → Handler/Controller → Service → Repository → Database
```

## Error Handling Patterns

### Try-Catch
```typescript
try {
  const result = await riskyOperation();
  return Ok(result);
} catch (error) {
  logger.error(error);
  return Err(handleError(error));
}
```

### Result Type
```typescript
type Result<T, E> = { ok: true; value: T } | { ok: false; error: E };
```

## Repository Pattern

```typescript
interface Repository<T> {
  findById(id: string): Promise<T | null>;
  create(data: CreateInput<T>): Promise<T>;
  update(id: string, data: UpdateInput<T>): Promise<T>;
  delete(id: string): Promise<void>;
}
```

## Transaction Pattern

```typescript
// Universal transaction syntax
await transaction(async (tx) => {
  // atomic operations
}, { isolation: 'Serializable' });
```
