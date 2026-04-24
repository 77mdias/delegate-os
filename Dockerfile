# Delegado OS - Container Image
FROM python:3.11-slim

LABEL maintainer="Delegado OS Team"
LABEL description="Agent Operating System for autonomous task delegation"

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    jq \
    tree \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app/

# Make scripts executable
RUN chmod +x delegado.sh
RUN find . -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true

# Environment variables
ENV DELEGADO_MODE=auto
ENV DELEGADO_KERNEL_PATH=/app/kernel
ENV DELEGADO_WORKFLOWS_PATH=/app/workflows

# Expose port for any web interface
EXPOSE 8080

# Default command
CMD ["./delegado.sh", "menu"]
