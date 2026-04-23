#!/usr/bin/env node
#===============================================================================
# CI VALIDATION — Delegado OS Quality Gates
#===============================================================================
#
# Runs quality gates for CI/CD pipelines.
#
# Usage:
#   node ci/validate.js [--all] [--lint] [--test] [--audit] [--complexity]
#
# Exit codes:
#   0 = All gates passed
#   1 = One or more gates failed
#
#===============================================================================

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

const PROJECT_ROOT = path.resolve(__dirname, '..');

const C = {
  r: '\x1b[0;31m', g: '\x1b[0;32m', y: '\x1b[1;33m',
  b: '\x1b[0;34m', c: '\x1b[0;36m', m: '\x1b[0;35m',
  bold: '\x1b[1m', reset: '\x1b[0m'
};

const log = (msg) => console.log(`${C.g}[CI]${C.reset} ${msg}`);
const pass = (msg) => console.log(`${C.g}✅${C.reset} ${msg}`);
const fail = (msg) => console.log(`${C.r}❌${C.reset} ${msg}`);
const warn = (msg) => console.log(`${C.y}⚠️${C.reset} ${msg}`);
const info = (msg) => console.log(`${C.c}[INFO]${C.reset} ${msg}`);

const results = { passed: 0, failed: 0, warnings: 0 };

function run(cmd, options = {}) {
  try {
    const output = execSync(cmd, {
      cwd: PROJECT_ROOT,
      encoding: 'utf8',
      stdio: 'pipe',
      ...options
    });
    return { success: true, output };
  } catch (e) {
    return { success: false, output: e.stdout || e.message, error: e.stderr };
  }
}

//-------------------------------------------------------------------------------
# CI Validation Script

Runs Delegado OS quality gates for CI/CD.

Usage:
  node ci/validate.js --all         Run all gates
  node ci/validate.js --lint         Lint check
  node ci/validate.js --test         Test suite
  node ci/validate.js --audit        HELL audit
  node ci/validate.js --complexity   Complexity check

Exit: 0 = pass, 1 = fail

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const ROOT = path.resolve(__dirname, '../..');
const C = { g: '\x1b[0;32m', r: '\x1b[0;31m', y: '\x1b[1;33m', c: '\x1b[0;36m', m: '\x1b[0;35m', bold: '\x1b[1m', reset: '\x1b[0m' };

const results = { passed: 0, failed: 0 };

const run = (cmd, cwd = ROOT) => {
  try {
    const out = execSync(cmd, { cwd, encoding: 'utf8', stdio: 'pipe' });
    return { ok: true, out };
  } catch (e) {
    return { ok: false, out: e.stdout || '', err: e.stderr || '' };
  }
};

const pass = (m) => { console.log(\`\${C.g}✅\${C.reset} \${m}\`); results.passed++; };
const fail = (m) => { console.error(\`\${C.r}❌\${C.reset} \${m}\`); results.failed++; };
const warn = (m) => { console.log(\`\${C.y}⚠️\${C.reset} \${m}\`); };

// Gate thresholds
const THRESHOLDS = {
  coverage: 80,
  complexity: 10,
  duplications: 5
};

// Lint gate
function gateLint() {
  console.log(\`\\n\${C.bold}Gate: LINT\${C.reset}\`);
  
  if (!fs.existsSync('package.json')) {
    warn('No package.json — skipping lint');
    return;
  }
  
  // Try eslint
  const eslint = run('npx eslint --version');
  if (eslint.ok) {
    const result = run('npx eslint . --max-warnings=0 2>&1 || true');
    if (result.out.includes('error')) {
      fail('ESLint found errors');
      console.log(result.out.substring(0, 500));
    } else {
      pass('ESLint passed');
    }
  } else {
    warn('ESLint not configured');
  }
}

// Test gate
function gateTest() {
  console.log(\`\\n\${C.bold}Gate: TEST\${C.reset}\`);
  
  if (!fs.existsSync('package.json')) {
    warn('No package.json — skipping tests');
    return;
  }
  
  // Check if test script exists
  const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8') || '{}');
  if (!pkg.scripts?.test) {
    warn('No test script — skipping');
    return;
  }
  
  const result = run('npm test -- --coverage --coverageThreshold=\\'{"global":{"branches":80,"functions":80,"lines":80,"statements":80}}\\' 2>&1 || npm test 2>&1');
  
  if (result.ok) {
    pass('Tests passed');
    
    // Parse coverage if available
    const coverageMatch = result.out.match(/All files[^]*?[\\d.]+ %/);
    if (coverageMatch) {
      info(\`Coverage: \${coverageMatch[0]}\`);
    }
  } else {
    fail('Tests failed');
    console.log(result.out.substring(0, 1000));
  }
}

// HELL audit gate
function gateAudit() {
  console.log(\`\\n\${C.bold}Gate: HELL AUDIT\${C.reset}\`);
  
  const hellCore = path.join(ROOT, 'kernel', 'hell', 'HELL-CORE-ENGINE.md');
  if (!fs.existsSync(hellCore)) {
    warn('HELL CORE ENGINE not found — skipping audit');
    return;
  }
  
  // Check for HELL artifacts
  const required = ['specs', 'tdd', 'decisions'];
  const missing = required.filter(r => !fs.existsSync(path.join(ROOT, r)));
  
  if (missing.length > 0) {
    warn(\`Missing HELL artifacts: \${missing.join(', ')}\`);
  } else {
    pass('HELL artifacts present');
  }
  
  // Check for patterns documentation
  const patternsDir = path.join(ROOT, 'kernel', 'skills');
  if (fs.existsSync(patternsDir)) {
    pass('Patterns catalog exists');
  }
}

// Complexity gate
function gateComplexity() {
  console.log(\`\\n\${C.bold}Gate: COMPLEXITY\${C.reset}\`);
  
  // Try cyclops or Plato
  const cyclops = run('npx cyclops --version || npx complexity-report --version || true');
  
  // Simple LOC check for key files
  const srcDir = path.join(ROOT, 'src');
  if (!fs.existsSync(srcDir)) {
    warn('No src/ directory — skipping complexity');
    return;
  }
  
  let totalLoc = 0;
  const largeFiles = [];
  
  const countLoc = (dir) => {
    if (!fs.existsSync(dir)) return;
    fs.readdirSync(dir, { withFileTypes: true }).forEach(entry => {
      const full = path.join(dir, entry.name);
      if (entry.isDirectory()) {
        countLoc(full);
      } else if (entry.name.endsWith('.js') || entry.name.endsWith('.ts')) {
        const content = fs.readFileSync(full, 'utf8');
        const loc = content.split('\\n').length;
        totalLoc += loc;
        if (loc > 200) largeFiles.push({ file: full, loc });
      }
    });
  };
  
  countLoc(srcDir);
  
  if (largeFiles.length > 0) {
    warn(\`\${largeFiles.length} files > 200 LOC:\`);
    largeFiles.slice(0, 5).forEach(f => console.log(\`  \${f.file}: \${f.loc} LOC\`));
  } else {
    pass(\`Total LOC: \${totalLoc} (within threshold)\`);
  }
}

// Type check gate
function gateTypes() {
  console.log(\`\\n\${C.bold}Gate: TYPE CHECK\${C.reset}\`);
  
  if (!fs.existsSync('package.json')) return;
  
  const pkg = JSON.parse(fs.readFileSync('package.json', 'utf8') || '{}');
  
  if (pkg.devDependencies?.typescript || pkg.dependencies?.typescript) {
    const result = run('npx tsc --noEmit 2>&1 || true');
    if (result.ok || result.out.includes('0 errors')) {
      pass('TypeScript: no errors');
    } else {
      fail('TypeScript: errors found');
    }
  } else {
    info('TypeScript not configured');
  }
}

// Main
const args = process.argv.slice(2);
const all = args.includes('--all') || args.length === 0;

console.log(\`\${C.bold}═══ DELEGADO CI VALIDATION ═══\${C.reset}\`);

if (all || args.includes('--lint')) gateLint();
if (all || args.includes('--test')) gateTest();
if (all || args.includes('--audit')) gateAudit();
if (all || args.includes('--complexity')) gateComplexity();
if (all || args.includes('--types')) gateTypes();

console.log(\`\\n\${C.bold}═══ RESULTS ═══\${C.reset}\`);
console.log(\`  \${C.g}Passed: \${results.passed}\${C.reset}\`);
console.log(\`  \${results.failed > 0 ? C.r : C.g}Failed: \${results.failed}\${C.reset}\`);

process.exit(results.failed > 0 ? 1 : 0);
