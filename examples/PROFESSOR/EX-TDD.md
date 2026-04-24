# Professor Mode Examples

## Example 1: Teaching TDD

**User:** "me ensina TDD"

**Agent Response:**

```
🎓 PROFESSOR MODE ACTIVATED

# Test-Driven Development (TDD)

## O que é TDD?

TDD é um ciclo de desenvolvimento onde você escreve os testes **ANTES** do código.

## O Ciclo Red-Green-Refactor

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│    RED      │ ──▶ │   GREEN     │ ──▶ │   REFACTOR   │
│             │     │             │     │             │
│ Escreva um  │     │ Faça o      │     │ Melhore o    │
│ teste que   │     │ teste       │     │ código sem    │
│ falha       │     │ passar      │     │ quebrar      │
└─────────────┘     └─────────────┘     └─────────────┘
        ▲                                            │
        │                                            │
        └────────────────────────────────────────────┘
                    Repita!
```

## Exemplo Prático

Vamos implementar uma função `calcular_desconto` usando TDD:

### Passo 1: RED - Escreva o teste primeiro

\`\`\`python
# test_desconto.py
import pytest
from desconto import calcular_desconto

def test_desconto_de_10_porcento():
    """Aplicar 10% de desconto em 100 deve resultar em 90"""
    assert calcular_desconto(100, 10) == 90.0

def test_desconto_de_20_porcento():
    """Aplicar 20% de desconto em 50 deve resultar em 40"""
    assert calcular_desconto(50, 20) == 40.0

def test_sem_desconto():
    """Desconto de 0% deve retornar valor original"""
    assert calcular_desconto(100, 0) == 100.0
\`\`\`

### Passo 2: GREEN - Faça o teste passar

\`\`\`python
# desconto.py
def calcular_desconto(valor, percentual):
    return valor - (valor * percentual / 100)
\`\`\`

### Passo 3: REFACTOR - Melhore se necessário

\`\`\`python
# desconto.py
from typing import Union

def calcular_desconto(valor: Union[int, float], percentual: Union[int, float]) -> float:
    """
    Calcula o valor com desconto aplicado.
    
    Args:
        valor: Valor original
        percentual: Percentual de desconto (0-100)
    
    Returns:
        Valor com desconto aplicado
    
    Raises:
        ValueError: Se percentual negativo
    """
    if percentual < 0:
        raise ValueError("Percentual não pode ser negativo")
    
    return valor * (1 - percentual / 100)
\`\`\`

## Por que TDD?

| Benefício | Descrição |
|-----------|----------|
| ✅ Design limpo | Forces you to think about API first |
| ✅ Segurança | Changes don't break existing features |
| ✅ Documentação | Tests are living docs |
| ✅ Confiança | Refactor without fear |

## Exercício para você

Tente implementar `calcular_juros` (valor, taxa, tempo) usando TDD!

Dica: `juros = valor * taxa * tempo / 100`
```

---

**Synced to:** `vault/10-EDUCATION/2024-01-TDD-Intro.md`
