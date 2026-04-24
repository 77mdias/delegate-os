# Debugging Techniques Guide

> Comprehensive debugging methodology for the DEBUGGER agent.

## 1. SCIENTIFIC METHOD FOR DEBUGGING

```
┌─────────────────────────────────────────────────────────────┐
│              SCIENTIFIC DEBUGGING METHOD                     │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  1. OBSERVE    → Gather evidence, reproduce the bug         │
│         ↓                                                │
│  2. HYPOTHESIZE → Form a testable theory                   │
│         ↓                                                │
│  3. PREDICT    → What should happen if theory is true?     │
│         ↓                                                │
│  4. EXPERIMENT → Test the hypothesis                       │
│         ↓                                                │
│  5. ANALYZE    → Do results match prediction?              │
│         ↓                                                │
│  ┌→  YES → HYPOTHESIZE → New prediction (generalize)     │
│  │                                                        │
│  NO └──────────→ Go back to step 2                        │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Step-by-Step Application

```python
# STEP 1: OBSERVE
# Bug report: "Function returns wrong value"

def calculate_total(items):
    total = 0
    for item in items:
        total += item['price']
    return total

# Test case that fails:
items = [{'price': 10}, {'price': 20}, {'price': 30}]
print(calculate_total(items))  # Expected: 60, Got: ???

# STEP 2: HYPOTHESIZE
# Hypothesis: "The function might be returning None or 0"

# STEP 3: PREDICT
# If hypothesis is true: "We never enter the loop or don't accumulate"

# STEP 4: EXPERIMENT
# Add debug prints:
total = 0
for item in items:
    print(f"Adding {item['price']}")
    total += item['price']
    print(f"Running total: {total}")

# STEP 5: ANALYZE
# If results show "Running total: 0" after first iteration → loop IS running
# But total isn't accumulating → item['price'] might be None?
```

---

## 2. RUBBER DUCK DEBUGGING

### The Method
Explain your code line-by-line to an inanimate object (rubber duck, plant, etc.)

### Why It Works
- Verbalizing forces precise thinking
- You notice gaps in logic you missed reading
- The act of explaining reveals assumptions

### Script Template

```python
"""
So this function takes a list of items...
Line 1: I initialize total to 0...
Line 2: I loop through each item...
Line 3: I access item['price']...
        Wait, what if 'price' key doesn't exist?
Line 4: I add it to total...

Actually, let me check if 'price' always exists...
"""
```

---

## 3. BINARY SEARCH DEBUGGING (Divide & Conquer)

```python
# Instead of reading entire codebase to find bug
# Binary search: Remove half, test, repeat

def binary_debug(code_section, test_fn):
    """Find bug location by halving search space"""
    
    def is_buggy(midpoint):
        # Temporarily comment out code after midpoint
        # Run tests
        # Return True if bug still exists
        pass
    
    low = 0
    high = len(code_section)
    
    while high - low > 1:
        mid = (low + high) // 2
        
        if is_buggy(mid):
            # Bug is in first half
            high = mid
        else:
            # Bug is in second half
            low = mid
    
    return low  # Bug is around this line
```

### Practical Application

```
Bug Report: "API returns 500 error"

Step 1: Comment out entire handler → returns 200 ✓ → Bug in handler
Step 2: Comment out half of handler → still 500 ✓ → Bug in first half
Step 3: Comment out quarter → 200 ✓ → Bug in second quarter
Step 4: Continue halving...
Step 5: Bug found in specific line: missing error handling
```

---

## 4. PRINTF DEBUGGING (Enhanced)

```python
import sys
from functools import wraps
import time

# Decorator-based debug
def debug(func):
    """Decorator to print function calls with arguments and return"""
    @wraps(func)
    def wrapper(*args, **kwargs):
        # Capture inputs
        input_args = f"args={args}, kwargs={kwargs}"
        print(f"🔍 ENTER: {func.__name__}({input_args})", 
              file=sys.stderr)
        
        # Time execution
        start = time.time()
        
        try:
            result = func(*args, **kwargs)
            elapsed = time.time() - start
            print(f"✅ EXIT:  {func.__name__} → {result} ({elapsed:.3f}s)",
                  file=sys.stderr)
            return result
        except Exception as e:
            elapsed = time.time() - start
            print(f"❌ ERROR: {func.__name__} raised {type(e).__name__}: {e} ({elapsed:.3f}s)",
                  file=sys.stderr)
            raise
    
    return wrapper

# Usage
@debug
def fetch_data(endpoint):
    return api.get(endpoint)


# Context manager for block debugging
from contextlib import contextmanager

@contextmanager
def debug_block(label):
    """Debug a specific block of code"""
    print(f"📦 ENTER BLOCK: {label}", file=sys.stderr)
    try:
        yield
    finally:
        print(f"📦 EXIT BLOCK: {label}", file=sys.stderr)

# Usage
with debug_block("data processing"):
    data = load_data()
    processed = transform(data)
    save(processed)
```

---

## 5. LOGGING DEBUGGING

```python
import logging
from logging.handlers import RotatingFileHandler

# Configure structured logging
logging.basicConfig(
    level=logging.DEBUG,
    format='%(asctime)s | %(levelname)-8s | %(name)s:%(funcName)s:%(lineno)d | %(message)s',
    handlers=[
        RotatingFileHandler('debug.log', maxBytes=1e6, backupCount=3),
        logging.StreamHandler(sys.stderr)
    ]
)

logger = logging.getLogger(__name__)

def process_order(order_id):
    logger.debug(f"Starting order processing", extra={'order_id': order_id})
    
    order = db.get_order(order_id)
    logger.debug(f"Fetched order", extra={'order': order, 'order_id': order_id})
    
    if not order:
        logger.warning(f"Order not found", extra={'order_id': order_id})
        return None
    
    items = order.get('items', [])
    logger.info(f"Processing {len(items)} items", extra={'order_id': order_id})
    
    total = sum(item['price'] * item['qty'] for item in items)
    logger.info(f"Calculated total", extra={'total': total, 'order_id': order_id})
    
    return {'order_id': order_id, 'total': total}
```

---

## 6. CORE DUMP ANALYSIS

### Python Post-Mortem Debugging

```python
import traceback
import sys
import pdb

def debug_on_exception(exc_type, exc_value, exc_traceback):
    """Automatically start debugger on unhandled exception"""
    if sys.flags.interactive:
        # Already in interactive mode
        return
    
    print("💥 UNHANDLED EXCEPTION!", file=sys.stderr)
    print("=" * 60, file=sys.stderr)
    traceback.print_exception(exc_type, exc_value, exc_traceback)
    print("=" * 60, file=sys.stderr)
    
    # Start post-mortem debugger
    pdb.pm()

# Install the exception handler
sys.excepthook = debug_on_exception


# Alternatively, use PDB directly
def analyze_crash():
    try:
        # Your code here
        risky_operation()
    except:
        # Drop into debugger at crash site
        pdb.post_mortem(sys.exc_info()[2])
```

---

## 7. REMOTE DEBUGGING

### PDB Remote

```python
# Server code (where bug occurs)
import pdb
import socket

def remote_debug(port=4444):
    """Start PDB listen on port for remote debugging"""
    pdb.set_trace()

# Client (your terminal)
# $ python -m pdb client_connect.py
# (Pdb) continue  # Wait for connection

# Or use:
# $ python -m pdb -c "continue" server.py 2>&6 | nc -l 4444
```

### Debugpy (VS Code Compatible)

```python
# Server: Add at start of code
import debugpy

# Listen for VS Code debugger
debugpy.listen(("0.0.0.0", 5678))
print("Waiting for debugger attachment...")
debugpy.wait_for_client()  # Block until debugger attaches
```

---

## 8. MEMORY DEBUGGING

```python
import tracemalloc
import sys

# Memory leak detection
tracemalloc.start()

def memory_heavy_function():
    # Take snapshot before
    snapshot1 = tracemalloc.take_snapshot()
    
    # Your operations
    data = [dict(zip(['a', 'b', 'c'], range(3))) for _ in range(100000)]
    
    # Take snapshot after
    snapshot2 = tracemalloc.take_snapshot()
    
    # Compare
    top_stats = snapshot2.compare_to(snapshot1, 'lineno')
    
    print("\nTop 10 memory allocations:")
    for stat in top_stats[:10]:
        print(stat)


# Object reference counting
import gc

def find_memory_leaks():
    """Find objects that should be garbage collected but aren't"""
    
    # Get all unreleased objects after a known clean point
    gc.collect()
    unreachable = gc.collect()
    
    print(f"Unreachable objects: {unreachable}")
    
    # Find objects with reference counts > 0
    for obj in gc.get_objects():
        if isinstance(obj, (list, dict, set)):
            ref_count = sys.getrefcount(obj) - 1  # Subtract 1 for the getrefcount call itself
            if ref_count > 10:  # Suspiciously high
                print(f"High ref count ({ref_count}): {type(obj).__name__}")
```

---

## 9. RACE CONDITION DEBUGGING

```python
import threading
import time
from contextlib import contextmanager

# Thread-aware debugging
lock = threading.Lock()
debug_enabled = threading.local()

@contextmanager
def thread_debug(name):
    """Context manager for thread-specific debug output"""
    debug_enabled.name = name
    print(f"[{name}] Starting in thread {threading.current_thread().name}")
    try:
        yield
    finally:
        print(f"[{name}] Finished")

def race_condition_prone_function(shared_state):
    with thread_debug("worker"):
        # Log what we're about to do
        current_value = shared_state['counter']
        print(f"[{threading.current_thread().name}] Read counter={current_value}")
        
        # Simulate time between read and write
        time.sleep(0.001)  # Forces context switch
        
        # Write back incremented value
        shared_state['counter'] = current_value + 1
        print(f"[{threading.current_thread().name}] Wrote counter={current_value + 1}")


# Running with deliberate thread interleaving
shared = {'counter': 0}
threads = [
    threading.Thread(target=race_condition_prone_function, args=(shared,))
    for _ in range(10)
]

for t in threads:
    t.start()
for t in threads:
    t.join()

print(f"Final counter: {shared['counter']}")  # Often NOT 10!
```

---

## 10. HEISENBUG HUNTING

### Characteristics of Heisenbugs
- Disappear when observed (debug print changes behavior)
- Appear intermittently
- Often related to timing, concurrency, or memory

### Debugging Techniques

```python
# 1. Make it reproducible
# If it's intermittent, it's often a race condition

# 2. Add more observation (ironic paradox)
# Sometimes Heisenberg is so subtle we need to observe without affecting

# 3. Use deterministic testing
import hypothesis
from hypothesis import given, strategies as st

@given(st.lists(st.integers(min_value=0, max_value=1000)))
def test_sort_is_stable(data):
    """Find inputs that break stability"""
    original = data.copy()
    sorted_data = stable_sort(data)
    
    # Check stability - if this fails intermittently, 
    # we found our heisenbug input
    assert sorted_data == sorted(original)


# 4. Remove parallelism to isolate
# If removing threading makes bug disappear → concurrency issue
# If removing caching makes bug disappear → cache coherence issue


# 5. Time-boxed reproduction
# Run same code 1000 times
for i in range(1000):
    result = your_function(input)
    if result != expected:
        print(f"Bug reproduced on iteration {i}!")
        print(f"Input: {input}")
        break
```

---

## 11. DEBUGGING CHECKLIST

### General Debugging

```
□ Can you reproduce the bug consistently?
□ What is the expected behavior?
□ What is the actual behavior?
□ When did this start happening? (Last working version?)
□ Does it happen on all inputs or specific ones?
□ Does it happen every time or intermittently?

Environment:
□ What version of Python/runtime?
□ What OS/environment?
□ What are the environment variables?
□ Is there any caching involved?

Code:
□ What is the minimal code to reproduce?
□ Does the bug exist in isolation?
□ Can you binary-search to find the exact line?

Tests:
□ Are there existing tests?
□ Do they pass without the bug?
□ Can you write a test that fails with the bug?
```

---

## 12. COMMON BUG PATTERNS

| Pattern | Symptom | Solution |
|---------|--------|----------|
| **Off-by-one** | Loop misses first/last element | Check range boundaries |
| **Mutable default arg** | Data persists between calls | Use `None` as default |
| **Reference vs value** | Changes affect original | `.copy()` or `deepcopy()` |
| **Float comparison** | `0.1 + 0.2 != 0.3` | Use `math.isclose()` |
| **String immutability** | Concatenation in loop slow | Use `join()` |
| **Generator exhaustion** | Second iteration empty | Convert to list or recreate |
| **Closure capture** | Loop variable captured wrong | Use default arg or partial |
| **Async not awaited** | Concurrent instead of sequential | Add `await` |
| **Dict key error** | Key doesn't exist | Use `.get()` or `setdefault()` |
| **Integer division** | `5 / 2 = 2` instead of `2.5` | Use `5 / 2` not `5 // 2` |

---

*This file is part of Delegado OS - DEBUGGER Agent Mode*
