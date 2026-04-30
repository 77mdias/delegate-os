# Debugger Mode Examples

## Example: Mystery Bug Analysis

**User:** "essa função tá retornando undefined quando não deveria"

**Agent Response:**

```
🔍 DEBUGGER MODE ACTIVATED

# Bug Analysis: Função Retornando Undefined

## 🔬 Investigação

### 1. Reprodução do Bug

Você consegue me dar:
1. O código completo da função?
2. Um exemplo de entrada que causa o `undefined`?
3. A mensagem de erro completa (se houver)?

### 2. Checklist de Causas Comuns

Enquanto isso, vou.listar as causas mais comuns de `undefined`:

```python
# ❌ CAUSA 1: Retorno implícito sem valor
def funcao_errada():
    resultado = calcular()
    if resultado < 0:
        return  # ❌ Retorna None!
    return resultado

# ✅ CORREÇÃO 1
def funcao_correta():
    resultado = calcular()
    if resultado < 0:
        return 0  # ou raise ValueError()
    return resultado

# ❌ CAUSA 2: Escopo de variável
def funcao_errada():
    if condicao:
        valor = 10
    return valor  # ❌ valor pode não existir!

# ✅ CORREÇÃO 2
def funcao_correta():
    valor = None  # valor inicial
    if condicao:
        valor = 10
    return valor if valor is not None else 0
```

### 3. Técnicas de Debugging

```python
# Adicione prints estratégicos
def sua_funcao(params):
    print(f"📥 Input: {params}")
    
    resultado = processar(params)
    print(f"⚙️ Processado: {resultado}")
    print(f"🔍 Tipo: {type(resultado)}")
    
    return resultado

# Ou use o debugger
import pdb; pdb.set_trace()
```

---

## 📝 Template para Reportar Bug

```markdown
## Bug Report

**Descrição:** [O que acontece]
**Esperado:** [O que deveria acontecer]
**Atual:** [O que acontece]

**Código:**
\`\`\`python
[seu código aqui]
\`\`\`

**Entrada de teste:**
\`\`\`python
[caso que causa o bug]
\`\`\`

**Saída atual:**
\`\`\`
[o que получается]
\`\`\`
```
