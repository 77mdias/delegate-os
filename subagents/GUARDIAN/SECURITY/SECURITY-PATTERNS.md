# Security Patterns & Best Practices

> Security checklist and patterns for the GUARDIAN agent.

## 1. OWASP TOP 10 (2021)

| Rank | Vulnerability | Quick Fix |
|------|--------------|----------|
| **A01** | Broken Access Control | Validate permissions on every endpoint |
| **A02** | Cryptographic Failures | Never roll your own crypto, use standard libs |
| **A03** | Injection | Parameterized queries, input validation |
| **A04** | Insecure Design | Threat modeling, secure defaults |
| **A05** | Security Misconfiguration | Hardened configs, minimal surface |
| **A06** | Vulnerable Components | Keep dependencies updated |
| **A07** | Auth Failures | Proper session management, 2FA |
| **A08** | Data Integrity Failures | Tamper-proof data, signing |
| **A09** | Logging Failures | Log security events, alert on anomalies |
| **A10** | SSRF | Validate and sanitize URLs |

---

## 2. INPUT VALIDATION

```python
# ❌ NEVER trust user input
def unsafe_query(user_id):
    query = f"SELECT * FROM users WHERE id = {user_id}"
    cursor.execute(query)

# ✅ Parameterized queries
def safe_query(user_id):
    query = "SELECT * FROM users WHERE id = %s"
    cursor.execute(query, (user_id,))

# ✅ Input validation
from pydantic import BaseModel, validator

class UserInput(BaseModel):
    email: str
    age: int
    
    @validator('email')
    def validate_email(cls, v):
        if '@' not in v:
            raise ValueError('Invalid email')
        return v.lower()
    
    @validator('age')
    def validate_age(cls, v):
        if v < 0 or v > 150:
            raise ValueError('Invalid age')
        return v
```

---

## 3. AUTHENTICATION PATTERNS

```python
# JWT Token Security
import jwt
from datetime import datetime, timedelta
import hashlib

class SecureTokenService:
    def __init__(self, secret: str, algorithm: str = "HS256"):
        self.secret = secret
        self.algorithm = algorithm
    
    def create_token(self, user_id: str, expires_in: int = 3600) -> str:
        """Create a signed JWT token"""
        payload = {
            'sub': user_id,
            'iat': datetime.utcnow(),
            'exp': datetime.utcnow() + timedelta(seconds=expires_in),
            'jti': hashlib.sha256(str(datetime.utcnow()).encode()).hexdigest()
        }
        return jwt.encode(payload, self.secret, algorithm=self.algorithm)
    
    def verify_token(self, token: str) -> dict:
        """Verify and decode token"""
        try:
            payload = jwt.decode(
                token, 
                self.secret, 
                algorithms=[self.algorithm],
                options={'require': ['sub', 'exp', 'iat', 'jti']}
            )
            return payload
        except jwt.ExpiredSignatureError:
            raise TokenExpiredError()
        except jwt.InvalidTokenError:
            raise InvalidTokenError()


# Password Hashing
import bcrypt

def hash_password(password: str) -> str:
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()

def verify_password(password: str, hashed: str) -> bool:
    return bcrypt.checkpw(password.encode(), hashed.encode())
```

---

## 4. RATE LIMITING

```python
import time
from collections import defaultdict
from functools import wraps
import hashlib

class RateLimiter:
    """Token bucket rate limiter"""
    
    def __init__(self, max_requests: int, window_seconds: int):
        self.max_requests = max_requests
        self.window = window_seconds
        self.requests = defaultdict(list)
    
    def is_allowed(self, identifier: str) -> bool:
        """Check if request is within rate limit"""
        now = time.time()
        window_start = now - self.window
        
        # Remove old requests
        self.requests[identifier] = [
            req_time for req_time in self.requests[identifier]
            if req_time > window_start
        ]
        
        if len(self.requests[identifier]) >= self.max_requests:
            return False
        
        self.requests[identifier].append(now)
        return True
    
    def get_retry_after(self, identifier: str) -> int:
        """Get seconds until next request allowed"""
        if not self.requests[identifier]:
            return 0
        oldest = min(self.requests[identifier])
        return int(self.window - (time.time() - oldest))


def rate_limit(max_requests: int, window_seconds: int):
    """Decorator for rate limiting functions"""
    limiter = RateLimiter(max_requests, window_seconds)
    
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            # Use client IP or user ID as identifier
            identifier = hashlib.sha256(str(args).encode()).hexdigest()
            
            if not limiter.is_allowed(identifier):
                retry_after = limiter.get_retry_after(identifier)
                raise RateLimitError(retry_after=retry_after)
            
            return func(*args, **kwargs)
        return wrapper
    return decorator


# Usage
@rate_limit(max_requests=100, window_seconds=60)
def api_endpoint():
    pass
```

---

## 5. SECUREHeaders

```python
# Security headers middleware
SECURITY_HEADERS = {
    # Prevent XSS
    'Content-Security-Policy': (
        "default-src 'self'; "
        "script-src 'self' 'nonce-{nonce}'; "
        "style-src 'self' 'unsafe-inline'; "
        "img-src 'self' data: https:; "
        "font-src 'self'; "
        "object-src 'none'; "
        "base-uri 'self'; "
        "form-action 'self'; "
        "frame-ancestors 'none';"
    ),
    
    # Prevent clickjacking
    'X-Frame-Options': 'DENY',
    
    # Prevent MIME sniffing
    'X-Content-Type-Options': 'nosniff',
    
    # XSS protection (legacy but still useful)
    'X-XSS-Protection': '1; mode=block',
    
    # Referrer policy
    'Referrer-Policy': 'strict-origin-when-cross-origin',
    
    # Permissions policy
    'Permissions-Policy': (
        'geolocation=(), '
        'camera=(), '
        'microphone=(), '
        'payment=(self)'
    ),
    
    # Strict transport security (HTTPS only)
    'Strict-Transport-Security': 'max-age=31536000; includeSubDomains; preload',
}
```

---

## 6. SECRETS MANAGEMENT

```python
# ❌ NEVER hardcode secrets
API_KEY = "sk-1234567890abcdef"  # IN SECURE!

# ✅ Environment variables
import os
API_KEY = os.environ.get('API_KEY')

# ✅ Secrets manager
from dataclasses import dataclass

@dataclass
class Secrets:
    database_url: str
    api_key: str
    jwt_secret: str

def load_secrets() -> Secrets:
    """Load secrets from environment or secret manager"""
    return Secrets(
        database_url=os.environ['DATABASE_URL'],
        api_key=os.environ['API_KEY'],
        jwt_secret=os.environ['JWT_SECRET'],
    )


# ✅ Use dotenv in development
# .env file (NEVER commit this!)
# DATABASE_URL=postgresql://user:pass@localhost/db
# API_KEY=sk-dev-xxxxx
from dotenv import load_dotenv
load_dotenv()  # Load .env file
```

---

## 7. SQL INJECTION PREVENTION

```python
# SQL Injection Attack Examples:
# User input: "1; DROP TABLE users; --"
# Unsafe:  "SELECT * FROM users WHERE id = " + user_input
# Result:  SELECT * FROM users WHERE id = 1; DROP TABLE users; --

# ✅ Safe patterns:

# Pattern 1: Parameterized queries (ALWAYS use this)
cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))

# Pattern 2: ORM (SQLAlchemy)
from sqlalchemy.orm import Session
result = session.query(User).filter(User.id == user_id).first()

# Pattern 3: Raw SQL with SQLAlchemy Core
from sqlalchemy import text
stmt = text("SELECT * FROM users WHERE id = :user_id")
result = session.execute(stmt, {"user_id": user_id})

# Pattern 4: Query Builder
from sqlalchemy import select
stmt = select(User).where(User.id == user_id)
```

---

## 8. XSS PREVENTION

```python
# ❌ Dangerous: Rendering user input as HTML
from django.template import Template, Context
template = Template("{{ user_input }}")  # XSS VULNERABLE!

# ✅ Safe: Auto-escaping
from django.template import Template, Context
template = Template("{{ user_input }}")  # Django auto-escapes!
# <script> → &lt;script&gt;

# ✅ React/JSX - auto-escapes by default
# <div>{userInput}</div>  # Safe!

# ❌ Dangerous in React - dangerouslySetInnerHTML
# <div dangerouslySetInnerHTML={{__html: userInput}} />  # XSS!

# ✅ DOMPurify for sanitization
import DOMPurify

def safe_html(user_input: str) -> str:
    """Sanitize HTML to prevent XSS"""
    return DOMPurify.sanitize(user_input, {
        'ALLOWED_TAGS': ['b', 'i', 'em', 'strong', 'a'],
        'ALLOWED_ATTR': ['href'],
    })

# ✅ Content Security Policy violations detection
import re

def detect_xss_payload(payload: str) -> bool:
    """Basic XSS payload detection"""
    patterns = [
        r'<script',
        r'javascript:',
        r'onerror=',
        r'onload=',
        r'<iframe',
        r'data:text/html',
    ]
    return any(re.search(p, payload, re.I) for p in patterns)
```

---

## 9. CSRF PROTECTION

```python
import secrets
import hashlib
from functools import wraps
from typing import Callable

class CSRFProtection:
    def __init__(self, secret: str):
        self.secret = secret
    
    def generate_token(self, session_id: str) -> str:
        """Generate CSRF token for session"""
        timestamp = str(int(time.time()))
        message = f"{session_id}:{timestamp}"
        signature = hmac.new(
            self.secret.encode(),
            message.encode(),
            hashlib.sha256
        ).hexdigest()
        return f"{timestamp}:{signature}"
    
    def validate_token(self, session_id: str, token: str) -> bool:
        """Validate CSRF token"""
        try:
            timestamp, signature = token.split(':')
            
            # Check timestamp (token valid for 1 hour)
            if int(time.time()) - int(timestamp) > 3600:
                return False
            
            # Verify signature
            message = f"{session_id}:{timestamp}"
            expected = hmac.new(
                self.secret.encode(),
                message.encode(),
                hashlib.sha256
            ).hexdigest()
            
            return hmac.compare_digest(signature, expected)
        except ValueError:
            return False


# Flask decorator example
csrf = CSRFProtection(os.environ['CSRF_SECRET'])

def csrf_protected(func: Callable) -> Callable:
    @wraps(func)
    def wrapper(*args, **kwargs):
        # Get token from header or form
        token = request.headers.get('X-CSRF-Token') or request.form.get('csrf_token')
        
        if not token or not csrf.validate_token(session['id'], token):
            abort(403, description="CSRF token invalid")
        
        return func(*args, **kwargs)
    return wrapper

# Usage
@app.post('/api/data')
@csrf_protected
def submit_data():
    pass
```

---

## 10. SECURITY CHECKLIST

### Before Deployment

```
Authentication & Authorization
□ Strong password requirements (min 12 chars, complexity)
□ Password hashing with bcrypt/argon2
□ Multi-factor authentication available
□ Session timeout configured
□ OAuth tokens have reasonable expiration
□ Refresh token rotation enabled

Input Validation
□ All user input validated
□ Parameterized queries for all DB access
□ File uploads validated (type, size, content)
□ URLs validated before fetching (SSRF prevention)

Data Protection
□ Sensitive data encrypted at rest
□ HTTPS enforced (TLS 1.2+)
□ No secrets in code or version control
□ Environment variables for configuration
□ PII properly handled (GDPR compliance)

Headers & Configuration
□ Security headers configured
□ CORS properly configured
□ Rate limiting on public endpoints
□ Error messages don't leak internal info
□ Debug mode disabled in production

Dependencies
□ Dependency audit run (npm audit, safety)
□ Known vulnerabilities patched
□ Minimal dependencies
□ No abandoned packages
```

---

*This file is part of Delegado OS - GUARDIAN Agent Mode*
