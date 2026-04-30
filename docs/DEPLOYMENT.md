# Deployment Guide

## Overview

This guide covers deploying Delegado OS in various environments.

## Local Development

### Quick Start

```bash
git clone https://github.com/delegado-os/delegado-os.git
cd delegado-os
make install
make test
```

### Manual Installation

```bash
# Clone repository
git clone https://github.com/delegado-os/delegado-os.git
cd delegado-os

# Install dependencies
./scripts/install.sh

# Setup Obsidian vault
./scripts/setup_obsidian_vault.sh ~/my-vault

# Configure environment
cp configs/sample.config .env
nano .env

# Test installation
./scripts/test.sh
```

## Docker Deployment

### Single Container

```bash
# Build image
docker build -t delegado-os:latest .

# Run container
docker run -d \
  --name delegado-os \
  -v ~/obsidian-vault:/root/obsidian-vault \
  -v ~/.delegado:/root/.delegado \
  -e DELEGADO_MODE=ORCHESTRATION \
  -p 8080:8080 \
  delegado-os:latest
```

### Docker Compose

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Production Docker Compose

```yaml
# docker-compose.prod.yml
version: '3.8'
services:
  delegado:
    build:
      context: .
      dockerfile: Dockerfile.prod
    restart: unless-stopped
    volumes:
      - ./data:/root/.delegado
      - ./vault:/root/obsidian-vault
    environment:
      - DELEGADO_MODE=${MODE}
      - API_TOKEN=${API_TOKEN}
    networks:
      - delegado-net

  obsidian:
    image: obsidianmd/obsidian:latest
    restart: unless-stopped
    volumes:
      - ./vault:/vault
    networks:
      - delegado-net

networks:
  delegado-net:
    driver: bridge
```

## Kubernetes Deployment

### Helm Chart

```bash
# Add helm repo
helm repo add delegado-os https://charts.delegado-os.dev
helm repo update

# Install chart
helm install delegado-os delegado-os/delegado-os \
  --set persistence.vault.size=10Gi \
  --set service.type=LoadBalancer
```

### Manual K8s

```bash
# Apply manifests
kubectl apply -f plugins/kubernetes/manifests/

# Check status
kubectl get pods -l app=delegado-os

# View logs
kubectl logs -l app=delegado-os -f
```

## Cloud Providers

### AWS (ECS/Fargate)

```bash
# Build and push to ECR
aws ecr get-login-password | docker login --username AWS --password-stdin $ECR_REGISTRY
docker build -t delegado-os:$TAG .
docker tag delegado-os:$TAG $ECR_REGISTRY/delegado-os:$TAG
docker push $ECR_REGISTRY/delegado-os:$TAG

# Deploy via ECS
aws ecs update-service --cluster delegado-cluster --service delegado-os --force-new-deployment
```

### Google Cloud (Cloud Run)

```bash
# Build
gcloud builds submit --tag gcr.io/$PROJECT_ID/delegado-os

# Deploy
gcloud run deploy delegado-os \
  --image gcr.io/$PROJECT_ID/delegado-os \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

### Azure (Container Instances)

```bash
# Create Azure Container Instance
az container create \
  --resource-group delegado-rg \
  --name delegado-os \
  --image $ACR_REGISTRY/delegado-os:latest \
  --dns-name-label delegado-os-$RANDOM \
  --ports 8080 \
  --environment-variables DELEGADO_MODE=ORCHESTRATION
```

## Monitoring Setup

### Prometheus Metrics

```yaml
# prometheus.yml
scrape_configs:
  - job_name: 'delegado-os'
    static_configs:
      - targets: ['delegado-os:9090']
    metrics_path: /metrics
```

### Grafana Dashboard

Import dashboard from `plugins/observability/grafana-dashboard.json`.

```bash
# Setup alerting
kubectl apply -f plugins/observability/alerts/
```

## Backup Strategy

### Automated Backups

```bash
# Enable backup plugin
export BACKUP_ENABLED=true
export BACKUP_SCHEDULE="0 2 * * *"
export BACKUP_RETENTION_DAYS=30

# Manual backup
./scripts/backup.sh --full
```

### Disaster Recovery

```bash
# Restore from backup
./scripts/restore.sh --backup-id=2024-01-15-020000

# Verify integrity
./scripts/verify.sh --backup-id=2024-01-15-020000
```

## Security Hardening

### Network Security

```bash
# Use VPN for remote access
# Enable firewall rules
ufw enable
ufw allow 8080/tcp  # API only
ufw deny 22/tcp      # SSH only from known IPs
```

### Secret Management

```bash
# Use Vault for secrets
export SECRET_PROVIDER=vault
export VAULT_ADDR=https://vault.internal
export VAULT_TOKEN=${VAULT_TOKEN}

# Rotate secrets regularly
./scripts/rotate_secrets.sh
```

## Performance Optimization

### Resource Limits

```yaml
# docker-compose.yml
services:
  delegado:
    deploy:
      resources:
        limits:
          cpus: '2'
          memory: 4G
        reservations:
          cpus: '1'
          memory: 2G
```

### Caching

```bash
# Enable Redis cache
export CACHE_ENABLED=true
export CACHE_REDIS_URL=redis://cache:6379
```

## Troubleshooting

### Container Issues

```bash
# View logs
docker logs delegado-os

# Enter container
docker exec -it delegado-os /bin/bash

# Check resource usage
docker stats delegado-os
```

### Permission Issues

```bash
# Fix permissions
sudo chown -R 1000:1000 ./data ./vault
sudo chmod -R 755 ./scripts
```

### Network Issues

```bash
# Check DNS resolution
docker exec delegado-os nslookup obsidian

# Test connectivity
docker exec delegado-os curl -v http://obsidian:8080
```
