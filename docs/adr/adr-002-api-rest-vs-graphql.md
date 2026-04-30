# ADR-002: API Style - REST vs GraphQL

**Status**: Accepted

**Date**: 2024-01-18

**Authors**: Delegado OS Team

**Deciders**: Delegado OS Team, API Maintainers

---

## Context

Delegado OS exposes APIs for:
- Agent-to-agent communication
- Plugin configuration and management
- Workflow definitions
- User/resource management
- Real-time event streaming

We need to choose an API style that supports:
- Complex queries (filtering, pagination, relationships)
- Real-time updates (webhooks, subscriptions)
- Developer experience (documentation, tooling)
- Performance (overhead, caching)
- Client diversity (web, mobile, CLI)

### Requirements Summary

| Requirement | Description |
|-------------|-------------|
| Complex queries | Nested resources, filtering, sorting |
| Real-time | Webhook subscriptions, live updates |
| Bandwidth efficiency | Minimize payload size |
| Caching | HTTP caching for performance |
| Tooling | Good IDE support, documentation generation |
| Learning curve | Team familiarity |

---

## Decision

We will use a **hybrid approach**:

1. **REST API** for:
   - CRUD operations on resources
   - Simple, predictable endpoints
   - HTTP caching benefits
   - Well-understood patterns

2. **WebSocket/SSE** for:
   - Real-time subscriptions
   - Live progress updates
   - Interactive agent communication

### REST Endpoints Structure

```
/api/v1/
├── agents/
│   ├── {agent_id}
│   ├── {agent_id}/tasks
│   └── {agent_id}/logs
├── plugins/
│   ├── {plugin_id}
│   └── {plugin_id}/config
├── workflows/
│   ├── {workflow_id}
│   └── {workflow_id}/runs
└── resources/
    ├── users/
    ├── projects/
    └── files/
```

### Response Format

All responses use consistent envelope:

```json
{
  "data": { ... },
  "meta": {
    "request_id": "req_abc123",
    "timestamp": "2024-01-18T10:30:00Z"
  },
  "error": null
}
```

### Error Format

```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request parameters",
    "details": [
      {
        "field": "email",
        "message": "Must be a valid email address"
      }
    ]
  }
}
```

---

## Consequences

### Positive

- **Familiarity**: REST is well-understood, easier onboarding
- **HTTP Caching**: Leverage CDN and browser caching
- **Simplicity**: Easier to debug, test, and mock
- **Tooling**: Excellent REST tooling (Postman, Insomnia, curl)
- **Documentation**: Auto-generates from OpenAPI spec
- **Scalability**: Stateless design scales horizontally

### Negative

- **Over-fetching**: Sometimes returns more data than needed
- **Multiple round-trips**: Complex queries require multiple requests
- **Versioning**: API versioning can be awkward

### Neutral

- **Real-time**: Requires separate WebSocket infrastructure
- **Subscriptions**: Not native to REST (use Webhooks instead)

---

## Alternatives Considered

### Option 1: GraphQL Only

**Pros**:
- Single endpoint, flexible queries
- No over-fetching
- Built-in subscriptions
- Self-documenting schema

**Cons**:
- Complexity for simple CRUD
- Caching more difficult
- Learning curve for team
- Potential for expensive queries (DoS)
- Overkill for our use case

**Decision**: Rejected - benefits don't justify complexity for our use case.

### Option 2: gRPC

**Pros**:
- High performance
- Strong typing with Protocol Buffers
- Built-in streaming

**Cons**:
- Not browser-native (requires proxy)
- Complex setup and debugging
- Limited tooling for debugging
- Team unfamiliarity

**Decision**: Rejected - better for service-to-service, not client-facing API.

---

## Implementation

### REST API Specification

- Use OpenAPI 3.1 for specification
- Version in URL: `/api/v1/`
- JSON request/response
- Standard HTTP methods: GET, POST, PATCH, DELETE
- Pagination: Cursor-based for large datasets

### OpenAPI Example

```yaml
openapi: 3.1.0
info:
  title: Delegado OS API
  version: 1.0.0
paths:
  /agents/{agent_id}:
    get:
      summary: Get agent
      parameters:
        - name: agent_id
          in: path
          required: true
          schema:
            type: string
      responses:
        '200':
          description: Success
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Agent'
```

### Real-time Implementation

For real-time needs:
- **Webhooks**: Server-to-server push events
- **Server-Sent Events (SSE)**: Simple one-way streaming
- **WebSocket**: Bidirectional for agent coordination

---

## References

- [REST API Design Rulebook](https://www.oreilly.com/library/view/rest-api-design/9781449317904/)
- [OpenAPI Specification](https://spec.openapis.org/)
- [Best Practices for REST API Design](https://stackoverflow.blog/2020/03/02/best-practices-for-rest-api-design/)
