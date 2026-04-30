# API Documentation Template

API Name and Version
===

## Overview

Brief description of what this API does and its purpose.

## Base URL

```
https://api.example.com/v1
```

## Authentication

Describe authentication method (API Key, OAuth2, JWT, etc.)

```bash
# Example: API Key header
curl -H "X-API-Key: your-api-key" https://api.example.com/v1/resource

# Example: Bearer token
curl -H "Authorization: Bearer your-token" https://api.example.com/v1/resource
```

## Rate Limiting

| Tier | Requests/minute | Burst |
|------|----------------|-------|
| Free | 60 | 10 |
| Pro | 600 | 100 |
| Enterprise | 6000 | 1000 |

---

## Resources

### Users

#### List Users

```
GET /users
```

**Query Parameters**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `page` | integer | No | 1 | Page number |
| `limit` | integer | No | 20 | Items per page (max 100) |
| `sort` | string | No | `created_at` | Sort field |
| `order` | string | No | `desc` | Sort order (`asc` or `desc`) |
| `status` | string | No | - | Filter by status |

**Response**

```json
{
  "data": [
    {
      "id": "usr_abc123",
      "email": "user@example.com",
      "name": "John Doe",
      "created_at": "2024-01-15T10:30:00Z",
      "status": "active"
    }
  ],
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "total_pages": 8
  }
}
```

---

#### Get User

```
GET /users/{id}
```

**Path Parameters**

| Parameter | Type | Description |
|-----------|------|-------------|
| `id` | string | User ID |

**Response**

```json
{
  "data": {
    "id": "usr_abc123",
    "email": "user@example.com",
    "name": "John Doe",
    "created_at": "2024-01-15T10:30:00Z",
    "updated_at": "2024-01-20T14:00:00Z",
    "status": "active",
    "metadata": {
      "plan": "pro",
      "source": "web"
    }
  }
}
```

**Error Responses**

| Status | Code | Description |
|--------|------|-------------|
| 400 | `INVALID_REQUEST` | Invalid request parameters |
| 401 | `UNAUTHORIZED` | Missing or invalid API key |
| 403 | `FORBIDDEN` | Insufficient permissions |
| 404 | `NOT_FOUND` | User not found |
| 429 | `RATE_LIMITED` | Rate limit exceeded |
| 500 | `INTERNAL_ERROR` | Server error |

---

#### Create User

```
POST /users
```

**Request Body**

```json
{
  "email": "user@example.com",
  "name": "John Doe",
  "password": "securepassword123",
  "metadata": {
    "source": "api"
  }
}
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `email` | string | Yes | User email (unique) |
| `name` | string | Yes | Display name |
| `password` | string | Yes | Password (min 8 chars) |
| `metadata` | object | No | Custom key-value pairs |

**Response**

```
Status: 201 Created
```

```json
{
  "data": {
    "id": "usr_xyz789",
    "email": "user@example.com",
    "name": "John Doe",
    "created_at": "2024-01-20T14:00:00Z",
    "status": "active"
  }
}
```

---

#### Update User

```
PATCH /users/{id}
```

**Request Body**

```json
{
  "name": "Jane Doe",
  "metadata": {
    "plan": "enterprise"
  }
}
```

Only include fields to update. All fields are optional.

**Response**

```json
{
  "data": {
    "id": "usr_abc123",
    "email": "user@example.com",
    "name": "Jane Doe",
    "updated_at": "2024-01-20T15:00:00Z",
    "status": "active"
  }
}
```

---

#### Delete User

```
DELETE /users/{id}
```

Permanently deletes the user.

**Response**

```
Status: 204 No Content
```

---

### Projects

#### List Projects

```
GET /projects
```

**Query Parameters**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user_id` | string | Yes | Filter by owner |
| `status` | string | No | Filter by status |

**Response**

```json
{
  "data": [
    {
      "id": "prj_abc123",
      "name": "My Project",
      "user_id": "usr_abc123",
      "status": "active",
      "created_at": "2024-01-10T09:00:00Z"
    }
  ]
}
```

---

## Webhooks

Receive real-time notifications when resources change.

### Setup

1. Create webhook endpoint in dashboard
2. Enter URL: `https://your-server.com/webhooks/delegate-os`
3. Select events to subscribe to
4. Copy signing secret

### Verification

All webhook requests include `X-Webhook-Signature` header:

```javascript
const crypto = require('crypto');

function verifyWebhook(payload, signature, secret) {
  const expected = crypto
    .createHmac('sha256', secret)
    .update(payload)
    .digest('hex');
  return crypto.timingSafeEqual(
    Buffer.from(signature),
    Buffer.from(expected)
  );
}
```

### Events

#### `user.created`

```json
{
  "event": "user.created",
  "timestamp": "2024-01-20T14:00:00Z",
  "data": {
    "id": "usr_xyz789",
    "email": "user@example.com",
    "name": "John Doe"
  }
}
```

#### `user.updated`

```json
{
  "event": "user.updated",
  "timestamp": "2024-01-20T15:00:00Z",
  "data": {
    "id": "usr_xyz789",
    "changes": ["name", "metadata"]
  }
}
```

#### `user.deleted`

```json
{
  "event": "user.deleted",
  "timestamp": "2024-01-20T16:00:00Z",
  "data": {
    "id": "usr_xyz789"
  }
}
```

---

## SDKs

Official libraries available:

| Language | Package | Repository |
|----------|---------|------------|
| JavaScript | `@example/api-client` | github.com/example/api-client-js |
| Python | `example-api` | github.com/example/api-client-python |
| Go | `example/api` | github.com/example/api-client-go |
| Ruby | `example_api` | github.com/example/api-client-ruby |

---

## Changelog

### v1.1.0 (2024-01-15)

- Added `metadata` field support
- New webhook events: `user.updated`
- Deprecated `GET /users/list` (use `GET /users`)

### v1.0.0 (2024-01-01)

- Initial API release
