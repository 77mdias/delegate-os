#!/usr/bin/env node
#===============================================================================
# HELL CYCLE AUTOMATION — Node.js Script
#===============================================================================
#
# Automates HELL method cycles with TDD, pattern detection, and commit hooks.
#
# Usage:
#   node hell-cycle.js spec <module>     # Create spec
#   node hell-cycle.js tdd <module>       # Run TDD cycle
#   node hell-cycle.js refactor <module>  # Apply refactor
#   node hell-cycle.js audit <module>     # Run audit
#   node hell-cycle.js milestone <type>   # Run milestone gate
#
#===============================================================================

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Config
const PROJECT_ROOT = path.resolve(__dirname, '..');
const KERNEL_DIR = path.join(PROJECT_ROOT, 'kernel');
const TEMPLATES_DIR = path.join(PROJECT_ROOT, 'templates', 'hell');

// Colors
const RED = '\x1b[0;31m';
const GREEN = '\x1b[0;32m';
const YELLOW = '\x1b[1;33m';
const BLUE = '\x1b[0;34m';
const CYAN = '\x1b[0;36m';
const MAGENTA = '\x1b[0;35m';
const BOLD = '\x1b[1m';
const RESET = '\x1b[0m';

const log = (msg, color = GREEN) => console.log(`${color}[HELL]${RESET} ${msg}`);
const info = (msg) => console.log(`${CYAN}[INFO]${RESET} ${msg}`);
const warn = (msg) => console.log(`${YELLOW}[WARN]${RESET} ${msg}`);
const error = (msg) => { console.error(`${RED}[ERROR]${RESET} ${msg}`); process.exit(1); };

//-------------------------------------------------------------------------------
// Utilities
//-------------------------------------------------------------------------------

const ensureDir = (dir) => {
    if (!fs.existsSync(dir)) {
        fs.mkdirSync(dir, { recursive: true });
        info(`Created: ${dir}`);
    }
};

const readFile = (file) => {
    try {
        return fs.readFileSync(file, 'utf8');
    } catch {
        return null;
    }
};

const writeFile = (file, content) => {
    fs.writeFileSync(file, content, 'utf8');
    info(`Written: ${file}`);
};

const template = (name, vars) => {
    let content = readFile(path.join(TEMPLATES_DIR, `${name}.template.md`)) ||
                  readFile(path.join(TEMPLATES_DIR, `${name}.md`)) ||
                  `# ${name}\n\nTemplate not found: ${name}`;
    
    Object.entries(vars).forEach(([key, val]) => {
        content = content.replace(new RegExp(`\\{\\{${key}\\}\\}`, 'g'), val);
    });
    
    return content;
};

//-------------------------------------------------------------------------------
// SPEC Phase
//-------------------------------------------------------------------------------

function runSpec(module) {
    if (!module) error('Module name required: hell-cycle.js spec <module>');
    
    log(`HELL SPEC — Specification Phase: ${module}`, MAGENTA);
    
    const specDir = path.join(PROJECT_ROOT, 'specs', module);
    ensureDir(specDir);
    
    const specFile = path.join(specDir, `hell-spec-${module}.md`);
    const specContent = template('hell-spec', {
        module,
        project: path.basename(PROJECT_ROOT),
        date: new Date().toISOString().split('T')[0]
    });
    
    writeFile(specFile, specContent);
    
    // Create TDD directory structure
    ensureDir(path.join(PROJECT_ROOT, 'tdd', module));
    ensureDir(path.join(PROJECT_ROOT, 'tdd', module, '__tests__'));
    
    log('HELL LOGIC GATE checklist:', CYAN);
    console.log(`
  ① INFORMATION EXPERT — Who has the data?
  ② PURE FABRICATION — Need artificial abstraction?
  ③ PROTECTED VARIATIONS — What can change?
  ④ INDIRECTION — Who mediates?
  ⑤ POLYMORPHISM — Complex conditional?
`);
    
    console.log(`
  GRASP Checklist:
    □ Information Expert — operates on OWN data?
    □ Creator — creates entities it contains/uses?
    □ Controller — no business logic in presentation?
    □ Low Coupling — ≤3 deps from same level?
    □ High Cohesion — ≤200 LOC or justified?

  Gate M-SPEC:
    □ All requirements have priority (MUST/SHOULD/COULD/WONT)
    □ Domain modeled (Entities, VOs, Aggregates)
    □ Variation points identified with interfaces
    □ Ubiquitous Language documented
`);
    
    return specFile;
}

//-------------------------------------------------------------------------------
// TDD Phase
//-------------------------------------------------------------------------------

function runTDD(module, options = {}) {
    if (!module) error('Module name required: hell-cycle.js tdd <module>');
    
    log(`HELL TDD — Red/Green/Refactor Cycle: ${module}`, MAGENTA);
    
    const specFile = path.join(PROJECT_ROOT, 'specs', module, `hell-spec-${module}.md`);
    if (!fs.existsSync(specFile)) {
        warn(`Spec not found. Run 'hell-cycle.js spec ${module}' first`);
    }
    
    const tddDir = path.join(PROJECT_ROOT, 'tdd', module);
    ensureDir(tddDir);
    
    // Create TDD log
    const logFile = path.join(tddDir, `hell-tdd-log-${module}.md`);
    const logContent = template('hell-tdd-log', {
        module,
        project: path.basename(PROJECT_ROOT),
        date: new Date().toISOString().split('T')[0]
    });
    writeFile(logFile, logContent);
    
    // Detect test framework
    let testCmd = 'npm test';
    let testExt = '.test.js';
    
    if (fs.existsSync('package.json')) {
        const pkg = JSON.parse(readFile('package.json') || '{}');
        if (pkg.devDependencies?.jest || pkg.dependencies?.jest) {
            testCmd = 'npm test';
            testExt = '.test.js';
        } else if (pkg.devDependencies?.vitest) {
            testCmd = 'npx vitest';
            testExt = '.test.js';
        } else if (pkg.devDependencies?.mocha) {
            testCmd = 'npx mocha';
            testExt = '.test.js';
        }
    }
    
    console.log(`
  ${RED}🔴 RED — Write failing test${RESET}
    1. Create test in: tdd/${module}/__tests__/
    2. Run: ${testCmd}
    3. Commit: \`test: RED — [test_name]\`
    
  ${GREEN}🟢 GREEN — Minimum code to pass${RESET}
    1. Write MINIMUM code to pass test
    2. NO optimization, NO extras
    3. Commit: \`feat: GREEN — [feature]\`
    
  ${BLUE}🔵 REFACTOR — Apply pattern, keep green${RESET}
    1. Apply GRASP/GoF pattern
    2. Keep all tests green
    3. Commit: \`refactor: [pattern] — [justification]\`
`);
    
    // If auto-run, attempt to run tests
    if (options.auto) {
        try {
            info('Running test suite...');
            execSync(testCmd, { stdio: 'inherit' });
            log('Tests passed', GREEN);
        } catch {
            warn('Tests failed or command not found');
        }
    }
    
    return logFile;
}

//-------------------------------------------------------------------------------
// REFACTOR Phase
//-------------------------------------------------------------------------------

function runRefactor(module, options = {}) {
    if (!module) error('Module name required: hell-cycle.js refactor <module>');
    
    log(`HELL REFACTOR — GoF Pattern Application: ${module}`, MAGENTA);
    
    const refactorDir = path.join(PROJECT_ROOT, 'refactor', module);
    ensureDir(refactorDir);
    
    console.log(`
  SMELL → PATTERN MAP:
    Conditional Complexity    → Strategy / State
    Constructor Overload      → Builder
    God Class                 → Facade + Decomposition
    Tight Coupling            → Observer / Mediator
    Duplicated Creation       → Factory Method
    Feature Envy              → Move Method (Expert)
`);
    
    console.log(`
  Safety Rules:
    1. Refactor ONE pattern at a time
    2. Run ALL tests between each refactor
    3. If test breaks → REVERT
    4. Commit: refactor(GoF): [pattern] — [module]
`);
    
    // Smell detection prompt
    const reportFile = path.join(refactorDir, `hell-refactor-${module}.md`);
    const reportContent = template('hell-refactor', {
        module,
        project: path.basename(PROJECT_ROOT),
        date: new Date().toISOString().split('T')[0]
    });
    writeFile(reportFile, reportContent);
    
    // Create ADR template
    const adrDir = path.join(PROJECT_ROOT, 'decisions');
    ensureDir(adrDir);
    
    const adrFile = path.join(adrDir, `HELL-ADR-${Date.now().toString().slice(-6)}.md`);
    const adrContent = template('hell-adr', {
        number: Date.now().toString().slice(-6),
        title: 'Pattern Application Decision',
        module,
        author: process.env.USER || 'agent',
        date: new Date().toISOString().split('T')[0]
    });
    writeFile(adrFile, adrContent);
    
    return { reportFile, adrFile };
}

//-------------------------------------------------------------------------------
// AUDIT Phase
//-------------------------------------------------------------------------------

function runAudit(module) {
    if (!module) error('Module name required: hell-cycle.js audit <module>');
    
    log(`HELL AUDIT — GRASP/SOLID Compliance: ${module}`, MAGENTA);
    
    const auditFile = path.join(PROJECT_ROOT, 'audit', `hell-audit-${module}.md`);
    const auditDir = path.dirname(auditFile);
    ensureDir(auditDir);
    
    const content = template('hell-audit', {
        module,
        project: path.basename(PROJECT_ROOT),
        author: process.env.USER || 'agent',
        date: new Date().toISOString().split('T')[0]
    });
    writeFile(auditFile, content);
    
    console.log(`
  GRASP Checklist per class:
    □ Information Expert — operates on OWN data?
    □ Creator — creates entities it contains/uses?
    □ Controller — no business logic in presentation?
    □ Low Coupling — ≤3 deps from same level?
    □ High Cohesion — ≤200 LOC or justified?
    □ Polymorphism — no switch/if >3 branches?
    □ Pure Fabrication — technical concerns separated?
    □ Indirection — mediators where needed?
    □ Protected Variations — interfaces for unstable points?

  SOLID Checklist:
    □ SRP — one reason to change?
    □ OCP — open for extension, closed for modification?
    □ LSP — subtypes substitute supertypes?
    □ ISP — no forced dependency on unused methods?
    □ DIP — depends on abstractions, not concretes?
`);
    
    return auditFile;
}

//-------------------------------------------------------------------------------
// MILESTONE Gate
//-------------------------------------------------------------------------------

function runMilestone(type) {
    if (!type) error('Milestone type required: hell-cycle.js milestone <M-SPEC|M-TEST|M-QUALITY|M-SHIP|M-REVIEW>');
    
    log(`HELL MILESTONE — Gate: ${type}`, MAGENTA);
    
    const gateDir = path.join(PROJECT_ROOT, 'milestones');
    ensureDir(gateDir);
    
    const gateFile = path.join(gateDir, `hell-milestone-${type.toLowerCase()}.md`);
    const content = template('hell-milestone', {
        type: type.toUpperCase(),
        project: path.basename(PROJECT_ROOT),
        author: process.env.USER || 'agent',
        date: new Date().toISOString().split('T')[0]
    });
    writeFile(gateFile, content);
    
    console.log(`
  VERDICT CRITERIA:
    ✅ PASSED    — Score ≥90% + zero critical
    ⚠️ CONDITIONAL — Score ≥70% + zero critical  
    ❌ BLOCKED   — Score <70% or critical failure
`);
    
    return gateFile;
}

//-------------------------------------------------------------------------------
// Main
//-------------------------------------------------------------------------------

const [,, cmd, arg, ...rest] = process.argv;
const options = { auto: rest.includes('--auto') };

switch (cmd) {
    case 'spec':
        runSpec(arg);
        break;
    case 'tdd':
        runTDD(arg, options);
        break;
    case 'refactor':
        runRefactor(arg, options);
        break;
    case 'audit':
        runAudit(arg);
        break;
    case 'milestone':
        runMilestone(arg);
        break;
    case 'help':
    default:
        console.log(`
  HELL Cycle Automation
  
  Usage:
    node hell-cycle.js spec <module>       # Create spec
    node hell-cycle.js tdd <module>       # Run TDD cycle
    node hell-cycle.js refactor <module>  # Apply refactor
    node hell-cycle.js audit <module>     # Run audit
    node hell-cycle.js milestone <type>   # Run milestone gate
  
  Options:
    --auto    # Auto-run tests
`);
}
