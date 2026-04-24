# Guardian Mode Examples

## Example: JWT Authentication Security Audit

**User:** "faz uma auditoria de segurança no nosso sistema de login com JWT"

**Agent Response:**

```
🛡️ GUARDIAN MODE ACTIVATED

# Security Audit: JWT Authentication System

## 📋 Scope

- **System:** Authentication API
- **Focus:** JWT implementation, token storage, session management
- **Severity Scale:** CVSS 3.1

---

## 1. Authentication Analysis

### ✅ What's Done Well

| Item | Status | Notes |
|------|--------|-------|
| Password Hashing | ✅ PASS | bcrypt with cost factor 12 |
| HTTPS Enforced | ✅ PASS | TLS 1.2+ in production |
| Rate Limiting | ✅ PASS | 5 attempts per 15 min per IP |

### ⚠️ Issues Found

```yaml
Issue 1: JWT Algorithm Confusion
═══════════════════════════════════════════════════════════
Severity: HIGH (8.2 CVSS)
Category: A07:2021 - Authentication Failures
Location: /auth/login.ts:45

Finding:
------
The server accepts both RS256 and HS256 algorithms.
An attacker can change the algorithm to HS256 and sign
the token with the public key (which is often shared).

Vulnerable Code:
---------------
const decoded = jwt.verify(token, process.env.JWT_SECRET, {
  algorithms: ['RS256', 'HS256']  // ❌ Allows both!
});

Recommendation:
--------------
✅ Explicitly specify only one algorithm
jwt.verify(token, publicKey, { algorithms: ['RS256'] });

✅ Never expose public keys in unsafe contexts
```

```yaml
Issue 2: Token Expiration Too Long
═══════════════════════════════════════════════════════════
Severity: MEDIUM (5.3 CVSS)
Category: A07:2021 - Authentication Failures

Current: Access token expires in 24 hours
Problem: If token is stolen, attacker has 24h access

Recommendation:
--------------
Access Token: 15 minutes
Refresh Token: 7 days (with rotation)
```

```yaml
Issue 3: No Token Rotation on Refresh
═══════════════════════════════════════════════════════════
Severity: MEDIUM (5.9 CVSS)

Finding: Refresh tokens can be reused after generation
Problem: If an attacker obtains a refresh token, they
         can get new access tokens indefinitely

Recommendation:
--------------
✅ Implement refresh token rotation
✅ Store refresh token hash in database
✅ Invalidate all tokens on password change
```

---

## 2. Authorization Analysis

### 🔍 Access Control Matrix

| Endpoint | Auth Required | Admin Only | Rate Limited |
|----------|---------------|------------|--------------|
| POST /auth/login | ❌ | ❌ | ✅ 5/min |
| POST /auth/refresh | ❌ | ❌ | ✅ 10/min |
| POST /auth/logout | ✅ | ❌ | ❌ |
| GET /users/profile | ✅ | ❌ | ✅ 100/min |
| DELETE /users/:id | ✅ | ✅ | ✅ 10/min |
| GET /admin/stats | ✅ | ✅ | ✅ 30/min |

### ❌ IDOR Vulnerability Found

```yaml
Issue 4: Insecure Direct Object Reference
═══════════════════════════════════════════════════════════
Severity: HIGH (7.5 CVSS)
Category: A01:2021 - Broken Access Control

Vulnerable Code:
----------------
app.get('/orders/:orderId', auth, async (req, res) => {
  const order = await db.orders.findById(req.params.orderId);
  res.json(order);  // ❌ No ownership check!
});

Attack Scenario:
---------------
1. Attacker logs in as user@example.com
2. GET /orders/12345 returns their order
3. Attacker changes to /orders/12346
4. If order belongs to another user, data is leaked

Recommendation:
---------------
✅ Always verify resource ownership
```javascript
app.get('/orders/:orderId', auth, async (req, res) => {
  const order = await db.orders.findOne({
    id: req.params.orderId,
    userId: req.user.id  // ✅ Ownership check
  });
  if (!order) return res.status(404).end();
  res.json(order);
});
```

---

## 3. Security Headers Check

```bash
# Current Headers
curl -I https://api.example.com/auth/login

Current Response Headers:
--------------------------
❌ Missing: Strict-Transport-Security
❌ Missing: X-Content-Type-Options: nosniff
❌ Missing: X-Frame-Options: DENY
⚠️  Missing: Content-Security-Policy
⚠️  Missing: X-XSS-Protection
✅ Present: Referrer-Policy: strict-origin-when-cross-origin
```

**Required Headers:**
```javascript
// Add to all responses
app.use((req, res, next) => {
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('Content-Security-Policy', "default-src 'self'");
  res.setHeader('X-XSS-Protection', '1; mode=block');
  res.setHeader('Referrer-Policy', 'strict-origin-when-cross-origin');
  next();
});
```

---

## 4. Input Validation

```yaml
Issue 5: No Input Sanitization on Login
═══════════════════════════════════════════════════════════
Severity: LOW (3.1 CVSS)
Category: A03:2021 - Injection

Finding: Email field accepts special characters without validation

Current:
-------
const { email, password } = req.body;
// No validation

Recommendation:
---------------
✅ Use a validation library
```javascript
const schema = Joi.object({
  email: Joi.string().email().required(),
  password: Joi.string().min(8).max(128).required()
});

const { error } = schema.validate(req.body);
if (error) return res.status(400).json({ error: error.details[0].message });
```

---

## 5. CVSS Score Summary

| Issue | CVSS | Vector | Remediation Effort |
|-------|------|--------|-------------------|
| Algorithm Confusion | 8.2 | CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:N | Low |
| Token Expiration | 5.3 | CVSS:3.1/AV:N/AC:L/PR:N/UI:N/SC:N/I:N/A:N | Low |
| Token Rotation | 5.9 | CVSS:3.1/AV:N/AC:L/PR:N/UI:N/SC:N/I:H/A:N | Medium |
| IDOR | 7.5 | CVSS:3.1/AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:N/A:N | Medium |
| Missing Headers | 5.3 | CVSS:3.1/AV:N/AC:L/PR:N/UI:N/SC:N/I:N/A:N | Low |

**Overall Risk:** MEDIUM (Requires attention within 2 weeks)

---

## 6. Remediation Priority

### 🔴 Immediate (This Week)
1. Fix JWT algorithm confusion - specify RS256 only
2. Add missing security headers
3. Implement access token shorter expiration (15min)

### 🟡 Short-term (This Month)
1. Implement refresh token rotation
2. Fix IDOR vulnerability
3. Add input validation with Joi/Zod

### 🟢 Long-term (This Quarter)
1. Add refresh token reuse detection
2. Implement additional MFA
3. Regular security audit schedule

---

## 7. Testing Commands

```bash
# Test for algorithm confusion
curl -X POST https://api.example.com/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"test"}'

# Check headers
curl -I https://api.example.com/auth/login

# Test rate limiting
for i in {1..10}; do
  curl -s -o /dev/null -w "%{http_code}\n" \
    -X POST https://api.example.com/auth/login \
    -d '{"email":"test@example.com","password":"wrong"}'
done
```

---

## 📝 Security Report Generated

**Report saved to:** `vault/40-SECURITY/2024-01-JWT-Audit.md`
**Next audit scheduled:** 2024-04-01
```

---

**Related Examples:**
- [EX-PATTERN.md](../ARCHITECT/EX-PATTERN.md) - Architecture patterns
- [EX-BUG-ANALYSIS.md](../DEBUGGER/EX-BUG-ANALYSIS.md) - Bug investigation
