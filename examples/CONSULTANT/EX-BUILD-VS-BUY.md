# Consultant Mode Examples

## Example: Build vs Buy Analysis for Logging System

**User:** "nossa empresa precisa de um sistema de logs centralizado, devo construir um interno ou usar um serviço como Datadog/Splunk?"

**Agent Response:**

```
💼 CONSULTANT MODE ACTIVATED

# Consulting Report: Centralized Logging System

## Executive Summary

**Recommendation: Hybrid approach (Datadog + Internal Pipeline)**

After analyzing your requirements, team capabilities, and budget constraints, I recommend starting with Datadog for 6 months while building internal competencies for a potential future migration. This minimizes risk while providing immediate value.

---

## Situation

**Current State:**
- 3 microservices in production (Node.js, Python, Go)
- 2 developers with ops responsibilities
- Growing from 50 to 200+ users in 6 months
- Current approach: SSH + grep on servers (not scalable)

**Problem:**
Logs are scattered across 3 services, making debugging and compliance difficult. Need centralized logging before scaling.

---

## Constraints

```yaml
Time: Need solution in 2-3 weeks
Budget: $2,000/month max
People: 2 devs with limited ops experience
Tech: Kubernetes on AWS, multi-service architecture
Compliance: Need 90-day log retention for audit
Scale: Currently 1M logs/day, expect 5x growth
```

---

## Options Analyzed

### Option 1: Datadog (SaaS) ⭐ RECOMMENDED

**Approach:** Use Datadog's full-stack observability platform

**Pros:**
- 🚀 Deployed in hours, not weeks
- 📊 Built-in dashboards, alerts, APM
- 🔍 Powerful log search with full-text indexing
- 👥 No dedicated ops needed
- 📈 Automatic scaling with growth
- 🔄 Good documentation and support

**Cons:**
- 💰 Cost scales with volume ($0.10 per ingested GB over free tier)
- 🔒 Data leaves your infrastructure (compliance review needed)
- 🔀 Vendor lock-in (migrate cost if you leave)

**Estimated Effort:** 1 week to integrate
**Risk:** Low
**Cost:** $1,200-1,800/month for expected volume

---

### Option 2: Self-Hosted (ELK Stack)

**Approach:** Elasticsearch + Logstash + Kibana on EC2

**Pros:**
- 💰 No per-GB cost (just infrastructure)
- 🔒 Full control of data
- 🔧 Customize pipeline as needed
- 📚 Large community, many tutorials

**Cons:**
- ⚠️ Requires dedicated ops attention
- ⚠️ Complex to scale (sharding, replication)
- ⚠️ 2-week initial setup + tuning
- ⚠️ Version upgrades are painful
- ⚠️ Storage costs at scale approach SaaS cost

**Estimated Effort:** 3-4 weeks initial setup
**Risk:** Medium (ops overhead)
**Cost:** $800-1,500/month EC2 + storage

---

### Option 3: OpenTelemetry + Custom Backend

**Approach:** OTel collector → Kafka → Elasticsearch/S3

**Pros:**
- 📊 Vendor-neutral, portable
- 🔧 Full customization
- 📚 Best practices via OTel standard

**Cons:**
- ⚠️ Significant initial investment (8+ weeks)
- ⚠️ Need ops expertise for Kafka/ES
- ⚠️ Building dashboards from scratch
- ⚠️ No managed offering for fast debugging

**Estimated Effort:** 8+ weeks
**Risk:** High (complex, unknown unknowns)
**Cost:** $1,000-2,000/month + engineering time

---

### Option 4: AWS CloudWatch

**Approach:** Native AWS logging service

**Pros:**
- ✅ Native integration with AWS services
- ✅ IAM-based access control
- ✅ No data transfer costs within AWS

**Cons:**
- ⚠️ Poor cross-cloud/hybrid support
- ⚠️ Limited query language
- ⚠️ Becomes expensive at scale
- ⚠️ Vendor lock-in to AWS

**Estimated Effort:** 1 week
**Risk:** Low-Medium
**Cost:** $1,500-2,500/month (infrastructure + ingestion)

---

## Comparison Summary

| Criteria | Datadog | ELK | OTel+Custom | CloudWatch |
|----------|---------|-----|-------------|------------|
| Time to Value | 9/10 | 5/10 | 2/10 | 7/10 |
| Cost at Scale | 6/10 | 7/10 | 8/10 | 5/10 |
| Ease of Use | 9/10 | 5/10 | 3/10 | 7/10 |
| Ops Overhead | 9/10 | 4/10 | 2/10 | 6/10 |
| Compliance | 8/10 | 10/10 | 10/10 | 8/10 |
| **TOTAL** | **8.2** | **5.2** | **5.0** | **6.6** |

---

## Recommendation

### Primary: **Datadog** (Start Now)

**Rationale:**

1. **Time constraint is critical** - You need logs in 2 weeks. Datadog wins here.
2. **Ops bandwidth is limited** - 2 developers can't also maintain ELK infrastructure.
3. **Cost is predictable** - $1,500/month is within budget and predictable.
4. **You can always migrate** - Use OTel SDK now, export format makes switching possible.

**Key Conditions for Success:**

1. ✅ Do a compliance review with your legal team (data stored in Datadog US)
2. ✅ Set up ingestion budget alerts to avoid surprise costs
3. ✅ Use Datadog's masking for PII before sending
4. ✅ Document the integration code for future reference

### Alternative: **ELK if...**

Choose self-hosted ELK if:
- Compliance forbids any external data processing
- You have dedicated ops/DevOps person
- You have 3+ months before deadline
- Budget is fixed (no per-GB billing)

---

## Action Plan

### This Week (Immediate)

- [ ] Sign up for Datadog trial (14 days free)
- [ ] Add Datadog agent to one service (pilot)
- [ ] Configure basic dashboards (error rate, latency, logs)
- [ ] Set up Slack alerts for errors
- [ ] Legal/compliance review of Datadog DPA

### This Month (Short-term)

- [ ] Roll out Datadog to all 3 microservices
- [ ] Define log retention policy (90 days for compliance)
- [ ] Set up PII masking in logs
- [ ] Document incident runbook with Datadog integration
- [ ] Train team on Datadog UI and search

### 6-Month Review

- [ ] Measure actual Datadog cost vs budget ($2k)
- [ ] Assess if ELK would actually be cheaper at scale
- [ ] Consider OTel for future portability
- [ ] Evaluate managed ELK options (Elastic Cloud, OpenSearch)

---

## Implementation Guide

### Step 1: Datadog Agent Installation

```bash
# Kubernetes (DaemonSet)
helm repo add datadog https://helm.datadoghq.com
helm install datadog datadog/datadog \
  --set apiKey=$DD_API_KEY \
  --set datadog.log.enabled=true \
  --set datadog.logs.enabled=true
```

### Step 2: Application Integration

```typescript
// Node.js with dd-trace
import tracer from 'dd-trace';

tracer.init({
  apiKey: process.env.DD_API_KEY,
  logInjection: true,  // Auto-correlate logs with traces
  env: process.env.NODE_ENV,
  service: 'my-service',
});

export default tracer;
```

### Step 3: Log Format (JSON for easy parsing)

```typescript
// Structured logging for Datadog
const logger = {
  info: (message: string, meta?: object) => {
    console.log(JSON.stringify({
      '@timestamp': new Date().toISOString(),
      level: 'info',
      message,
      service: 'my-service',
      env: process.env.NODE_ENV,
      ...meta,
    }));
  },
  error: (message: string, error?: Error, meta?: object) => {
    console.error(JSON.stringify({
      '@timestamp': new Date().toISOString(),
      level: 'error',
      message,
      error: {
        message: error?.message,
        stack: error?.stack,
      },
      service: 'my-service',
      env: process.env.NODE_ENV,
      ...meta,
    }));
  },
};
```

### Step 4: Essential Dashboard Queries

```yaml
# Error rate in last 5 minutes
sum:trace.elapsed.errors{env:production}.as_rate() / sum:trace.elapsed.total{env:production}.as_rate()

# Slow requests (>1s)
avg:trace.http.request.duration{env:production,resource_name:/api/*} > 1

# Log search for errors
@error.message:* @env:production
```

---

## Success Metrics

| Metric | Target | Current | Method |
|-------|--------|---------|--------|
| MTTR (Mean Time to Resolve) | < 30 min | Unknown | Datadog incident tracking |
| Time to find relevant logs | < 5 min | > 30 min | Manual measurement |
| Alert response time | < 10 min | Manual | Datadog monitor history |
| Log ingestion cost | < $2k/month | $0 | Datadog billing |

---

## Fallback Plan

If Datadog costs exceed $2,500/month at 6-month review:

1. **Short-term:** Reduce retention, exclude verbose logs
2. **Medium-term:** Migrate to ELK (your OTel instrumentation makes this possible)
3. **Long-term:** Build internal pipeline with Kafka + S3 + Athena

---

## Open Questions to Resolve

1. Does Datadog meet your data residency requirements?
2. Do you have PII in logs that needs masking?
3. Who owns the Datadog account and billing?
4. Do you need audit logs for compliance beyond Datadog's retention?

---

**Report saved to:** `vault/70-CONSULTING/2024-01-Logging-System-Build-vs-Buy.md`
**Decision deadline:** Make selection within 5 business days
```

---

**Related Examples:**
- [EX-PATTERN.md](../ARCHITECT/EX-PATTERN.md) - Architecture decisions
- [EX-SECURITY-AUDIT.md](../GUARDIAN/EX-SECURITY-AUDIT.md) - Security considerations
- [EX-PACKAGE-COMPARISON.md](../RESEARCHER/EX-PACKAGE-COMPARISON.md) - Technology research
