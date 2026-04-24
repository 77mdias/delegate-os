# API Integration Plugin

The API Integration Plugin provides comprehensive handling for external API communications, webhooks, and service-to-service interactions within Delegado OS.

## Overview

This plugin standardizes how Delegado OS agents interact with external APIs, ensuring consistent authentication, error handling, retry logic, and response parsing across all integrations.

## Features

### Webhook Handler
Receives and processes incoming webhooks from external services:
- Signature verification (HMAC, JWT)
- Event parsing and routing
- Idempotency handling
- Retry acknowledgment

### API Testing
Automated testing framework for API endpoints:
- Health check monitoring
- Response validation
- Performance benchmarking
- Error scenario testing

### Authentication Management
Supports multiple authentication schemes:
- Bearer tokens (JWT, OAuth2)
- API keys (header, query param)
- OAuth2 flows (client credentials, refresh token)
- Basic authentication

### Rate Limiting & Retry Logic
Built-in protection against API throttling:
- Configurable rate limiting
- Exponential backoff retries
- Circuit breaker pattern
- Request queuing

## Usage

### Webhook Handler

```bash
./webhook_handler.sh --provider github --event push --payload_file /tmp/webhook.json
```

Options:
- `--provider` - External service name (github, stripe, slack, etc.)
- `--event` - Event type to handle
- `--payload_file` - Path to JSON payload
- `--signature` - Webhook signature for verification

### API Testing

```bash
./api_test.sh --endpoint https://api.example.com/health --expected_status 200
```

Options:
- `--endpoint` - API URL to test
- `--expected_status` - Expected HTTP status code
- `--method` - HTTP method (GET, POST, PUT, DELETE)
- `--body` - Request body for POST/PUT
- `--headers` - Custom headers as JSON

## Configuration

Edit `manifest.yaml` to configure:

```yaml
configuration:
  timeout: 30
  retry_attempts: 3
  rate_limit_per_minute: 60
```

## Integration with Mode System

The API Integration plugin works seamlessly with all Delegado OS modes:

| Mode | Integration Point |
|------|------------------|
| SPEC | Validate API contracts in specs |
| CODE | Generate API client code |
| TEST | Create API integration tests |
| REVIEW | Audit API usage and security |
| DEBUG | Trace API call issues |
| SECURE | Verify auth and permissions |
| OPTIMIZE | Improve API performance |

## Examples

### GitHub Webhook Processing

```bash
./webhook_handler.sh \
  --provider github \
  --event pull_request \
  --payload_file events/pr.json \
  --secret $GITHUB_WEBHOOK_SECRET
```

### Stripe Webhook Processing

```bash
./webhook_handler.sh \
  --provider stripe \
  --event payment_intent.succeeded \
  --payload_file events/payment.json \
  --signature $STRIPE_SIGNATURE
```

### Health Check Test

```bash
./api_test.sh \
  --endpoint https://api.example.com/health \
  --expected_status 200 \
  --timeout 10
```

### Authenticated API Test

```bash
./api_test.sh \
  --endpoint https://api.example.com/users \
  --method GET \
  --headers '{"Authorization": "Bearer '$TOKEN'"}'
```

## Error Handling

The plugin returns standardized exit codes:

| Code | Meaning |
|------|--------|
| 0 | Success |
| 1 | General error |
| 2 | Authentication failed |
| 3 | Rate limit exceeded |
| 4 | Invalid response |
| 5 | Timeout |

## See Also

- [Plugins Documentation](../../PLUGINS.md)
- [Mode Comparison](../MODE-COMPARISON.md)
- [Best Practices](../BEST-PRACTICES.md)
