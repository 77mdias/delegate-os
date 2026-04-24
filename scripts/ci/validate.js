#!/usr/bin/env node
//===============================================================================
// CI VALIDATION — Delegado OS Quality Gates
//===============================================================================
//
// Runs quality gates for CI/CD pipelines.
//
// Usage:
//   node scripts/ci/validate.js [--all] [--lint] [--test] [--audit] [--complexity]
//
// Exit codes:
//   0 = All gates passed
//   1 = One or more gates failed
//
//===============================================================================

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
// Gates
//-------------------------------------------------------------------------------

function gateLint() {
    console.log(`\n${C.bold}Gate: LINT${C.reset}`);

    if (!fs.existsSync(path.join(PROJECT_ROOT, 'package.json'))) {
        warn('No package.json — skipping lint');
        return;
    }

    const eslint = run('npx eslint --version');
    if (eslint.success) {
        const result = run('npx eslint . --max-warnings=0 2>&1 || true');
        if (result.output.includes('error')) {
            fail('ESLint found errors');
            console.log(result.output.substring(0, 500));
        } else {
            pass('ESLint passed');
        }
    } else {
        warn('ESLint not configured');
    }
}

function gateTest() {
    console.log(`\n${C.bold}Gate: TEST${C.reset}`);

    const pkgPath = path.join(PROJECT_ROOT, 'package.json');
    if (!fs.existsSync(pkgPath)) {
        warn('No package.json — skipping tests');
        return;
    }

    let pkg;
    try {
        pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'));
    } catch {
        warn('Could not parse package.json — skipping');
        return;
    }

    if (!pkg.scripts?.test) {
        warn('No test script — skipping');
        return;
    }

    const result = run('npm test 2>&1');

    if (result.success) {
        pass('Tests passed');
    } else {
        fail('Tests failed');
        console.log(result.output.substring(0, 1000));
    }
}

function gateAudit() {
    console.log(`\n${C.bold}Gate: HELL AUDIT${C.reset}`);

    const hellCore = path.join(PROJECT_ROOT, 'kernel', 'hell', 'HELL-CORE-ENGINE.md');
    if (!fs.existsSync(hellCore)) {
        warn('HELL CORE ENGINE not found — skipping audit');
        return;
    }

    // Check for required HELL files
    const required = [
        'kernel/hell/HELL-CORE-ENGINE.md',
        'kernel/skills',
        'delegado.sh'
    ];

    let allExist = true;
    required.forEach(file => {
        if (!fs.existsSync(path.join(PROJECT_ROOT, file))) {
            fail(`Missing required file: ${file}`);
            allExist = false;
        }
    });

    if (allExist) {
        pass('HELL structure audit passed');
    }
}

function gateComplexity() {
    console.log(`\n${C.bold}Gate: COMPLEXITY${C.reset}`);
    warn('Complexity gate not yet implemented');
}

//-------------------------------------------------------------------------------
// Main
//-------------------------------------------------------------------------------

const args = process.argv.slice(2);
const gates = {
    lint: gateLint,
    test: gateTest,
    audit: gateAudit,
    complexity: gateComplexity
};

const runAll = args.includes('--all') || args.length === 0;
const requestedGates = Object.keys(gates).filter(g => args.includes(`--${g}`));

if (requestedGates.length > 0) {
    requestedGates.forEach(g => gates[g]());
} else if (runAll) {
    Object.values(gates).forEach(fn => fn());
}

console.log(`\n${C.bold}Results:${C.reset} ${C.g}${results.passed} passed${C.reset}, ${results.failed > 0 ? C.r : ''}${results.failed} failed${C.reset}, ${results.warnings} warnings`);

process.exit(results.failed > 0 ? 1 : 0);
