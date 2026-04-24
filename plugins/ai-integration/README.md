# AI Integration Plugin

Unified AI integration plugin for Delegado OS supporting multiple LLM providers.

## Supported Providers

### OpenAI
- **Models**: GPT-4o, GPT-4o-mini, GPT-4-Turbo, GPT-3.5-Turbo
- **API**: OpenAI Chat Completions API
- **Env Vars**: `OPENAI_API_KEY`, `OPENAI_ORG_ID` (optional)

### Anthropic
- **Models**: Claude Sonnet 4, Claude 3.5 Sonnet, Claude 3 Opus, Claude 3 Haiku
- **API**: Anthropic Messages API
- **Env Vars**: `ANTHROPIC_API_KEY`

### Ollama (Local Models)
- **Models**: Llama 3.2, Mistral, CodeLlama, Phi-3
- **API**: Ollama REST API
- **Endpoint**: `http://localhost:11434`

### LM Studio (Local Models)
- **Models**: Any model downloaded in LM Studio
- **API**: OpenAI-compatible API
- **Endpoint**: `http://localhost:1234/v1`

## Configuration

Edit `manifest.yaml` to configure providers:

```yaml
config:
  default_provider: openai
  providers:
    openai:
      models:
        - gpt-4o
      api_key_env: OPENAI_API_KEY
  fallback_chain:
    - openai
    - anthropic
    - ollama
```

## Environment Variables

Create a `.env` file or set these in your shell:

```bash
# OpenAI
export OPENAI_API_KEY=sk-...

# Anthropic
export ANTHROPIC_API_KEY=sk-ant-...

# Optional: Organization ID for OpenAI
export OPENAI_ORG_ID=org-...
```

## Usage

### Provider Selection

The plugin automatically selects providers based on:

1. **Explicit config**: Set `default_provider` in manifest.yaml
2. **Task context**: Code generation → prefer Claude/OpenAI, simple tasks → local models
3. **Fallback chain**: If primary fails, tries next in chain

### Hooks

#### `on_llm_request`
Called before each LLM request. Receives:
- `PROVIDER` - Current provider name
- `MODEL` - Model being used
- `PROMPT` - The prompt being sent

#### `on_llm_response`
Called after each LLM response. Receives:
- `PROVIDER` - Provider used
- `MODEL` - Model used
- `LATENCY_MS` - Request latency
- `TOKENS_USED` - Tokens consumed

#### `on_model_switch`
Called when switching models/providers. Receives:
- `FROM_PROVIDER` - Previous provider
- `TO_PROVIDER` - New provider
- `REASON` - Reason for switch

### Local Model Setup

#### Ollama
```bash
# Install Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Pull models
ollama pull llama3.2
ollama pull codellama

# Start server (runs automatically)
ollama serve
```

#### LM Studio
1. Download LM Studio from https://lmstudio.ai
2. Download your desired model
3. Start local server (UI button)
4. API available at `http://localhost:1234/v1`

## Cost Optimization

- **Local models** for: experimentation, learning, simple tasks
- **Cloud models** for: production, complex reasoning, latest capabilities
- **Caching**: Enable `cache_enabled: true` to reduce redundant API calls
- **Fallback chain**: Prevents failures due to single provider outages

## Troubleshooting

### "API key not found"
Ensure environment variables are set:
```bash
source ~/.delegado/.env
```

### "Connection refused" for local models
- Ollama: Run `ollama serve`
- LM Studio: Click "Start Server" in the app

### Rate limiting
The plugin implements automatic retry with exponential backoff via the fallback chain.
