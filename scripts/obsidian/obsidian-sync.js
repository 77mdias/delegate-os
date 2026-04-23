#!/usr/bin/env node
#===============================================================================
# OBSIDIAN SYNC — Bidirectional Sync with Delegado OS
#===============================================================================
#
# Syncs HELL artifacts between Delegado OS and Obsidian vault.
#
# Usage:
#   node obsidian-sync.js init [vault-path]     # Initialize vault
#   node obsidian-sync.js sync [vault-path]     # Full sync
#   node obsidian-sync.js push [vault-path]      # Local → Obsidian
#   node obsidian-sync.js pull [vault-path]      # Obsidian → Local
#   node obsidian-sync.js status [vault-path]    # Show sync status
#   node obsidian-sync.js watch [vault-path]     # Watch mode
#
#===============================================================================

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

// Config
const PROJECT_ROOT = path.resolve(__dirname, '..');
const OBSIDIAN_ENV = process.env.OBSIDIAN_VAULT;

const RED = '\x1b[0;31m';
const GREEN = '\x1b[0;32m';
const YELLOW = '\x1b[1;33m';
const CYAN = '\x1b[0;36m';
const MAGENTA = '\x1b[0;35m';
const RESET = '\x1b[0m';

const log = (msg) => console.log(`${GREEN}[OBSIDIAN]${RESET} ${msg}`);
const info = (msg) => console.log(`${CYAN}[INFO]${RESET} ${msg}`);
const warn = (msg) => console.log(`${YELLOW}[WARN]${RESET} ${msg}`);
const error = (msg) => { console.error(`${RED}[ERROR]${RESET} ${msg}`); process.exit(1); };

//-------------------------------------------------------------------------------
// Vault Structure
//-------------------------------------------------------------------------------

const VAULT_STRUCTURE = {
    '00-INBOX': { type: 'folder', desc: 'Unprocessed notes' },
    '01-PROJECTS': { type: 'folder', desc: 'Project notes' },
    '02-PATTERNS': {
        type: 'folder',
        desc: 'Pattern catalog',
        children: {
            'GRASP': { type: 'folder', desc: 'GRASP patterns' },
            'GoF': { type: 'folder', desc: 'GoF patterns' }
        }
    },
    '03-DASHBOARDS': { type: 'folder', desc: 'Dataview dashboards' },
    '04-TEMPLATES': { type: 'folder', desc: 'Templater templates' },
    '05-ARCHIVE': { type: 'folder', desc: 'Archived notes' },
    '06-REPOSITORIES': { type: 'folder', desc: 'Per-repo notes' },
    '04-AGENTS': { type: 'folder', desc: 'Agent-specific notes' }
};

//-------------------------------------------------------------------------------
# Obsidian Sync Script — Bidirectional Sync

Syncs HELL artifacts, memory, and context between Delegado OS and Obsidian vault.

Usage:
  node obsidian-sync.js init [vault-path]     Initialize vault structure
  node obsidian-sync.js sync [vault-path]     Full bidirectional sync
  node obsidian-sync.js push [vault-path]     Local → Obsidian
  node obsidian-sync.js pull [vault-path]     Obsidian → Local
  node obsidian-sync.js status [vault-path]    Show sync status
  node obsidian-sync.js watch [vault-path]     Watch mode

Environment:
  OBSIDIAN_VAULT     Path to Obsidian vault (overrides argument)
  OBSIDIAN_IGNORE    Patterns to ignore (comma-separated)

const fs = require('fs');
const path = require('path');
const os = require('os');

const PROJECT_ROOT = path.resolve(__dirname, '..');
const VAULT_PATH = process.env.OBSIDIAN_VAULT || '';

const C = {
  r: '\x1b[0;31m', g: '\x1b[0;32m', y: '\x1b[1;33m',
  b: '\x1b[0;34m', c: '\x1b[0;36m', m: '\x1b[0;35m',
  bold: '\x1b[1m', reset: '\x1b[0m'
};

const log = (msg, c = C.g) => console.log(`${c}[OBSIDIAN]${C.reset} ${msg}`);
const info = (msg) => log(msg, C.c);
const warn = (msg) => log(msg, C.y);
const error = (msg) => { console.error(`${C.r}[ERROR]${C.reset} ${msg}`); process.exit(1); };

const readFile = (f) => { try { return fs.readFileSync(f, 'utf8'); } catch { return null; } };
const writeFile = (f, c) => { fs.writeFileSync(f, c, 'utf8'); info(`Written: ${path.basename(f)}`); };
const exists = (f) => fs.existsSync(f);
const isDir = (f) => fs.statSync(f).isDirectory();
const mkdir = (d) => { if (!exists(d)) { fs.mkdirSync(d, { recursive: true }); info(`Created: ${d}`); } };

const VAULT_STRUCTURE = [
  '00-INBOX',
  '01-PROJECTS',
  '02-PATTERNS/GRASP',
  '02-PATTERNS/GoF',
  '03-DASHBOARDS',
  '04-TEMPLATES',
  '04-AGENTS',
  '05-ARCHIVE',
  '06-REPOSITORIES'
];

const LOCAL_ARTIFACTS = [
  { src: 'specs', dest: '01-PROJECTS' },
  { src: 'tdd', dest: '01-PROJECTS' },
  { src: 'decisions', dest: '01-PROJECTS' },
  { src: 'memory', dest: '05-ARCHIVE' },
  { src: 'audit', dest: '01-PROJECTS' }
];

const DASHBOARD_TEMPLATE = `# HELL Overview Dashboard

\`\`\`dataview
TABLE HELL_Phase, HELL_Gate, Status
FROM #hell
WHERE Status = "🔥 ACTIVE"
SORT Updated DESC
\`\`\`

## Recent Changes

\`\`\`dataview
TABLE file.ctime as Created, HELL_Phase
FROM #hell
LIMIT 10
SORT file.ctime DESC
\`\`\`
`;

function initVault(vault) {
  log('Initializing vault structure...', C.m);
  mkdir(vault);
  VAULT_STRUCTURE.forEach(dir => {
    mkdir(path.join(vault, dir));
  });

  // Create main dashboard
  writeFile(path.join(vault, '03-DASHBOARDS', 'HELL-Overview.md'), DASHBOARD_TEMPLATE);

  // Create agent registry
  const agentReg = `# Agent Registry

| Agent | Runtime | HELL Specialty | Status |
|-------|---------|----------------|--------|
`;
  writeFile(path.join(vault, '04-AGENTS', 'agent-registry.md'), agentReg);

  // Create context tracker
  const context = `# Shared Context

## Current Project

\`\`\`yaml
project: null
hell_phase: null
last_sync: ${new Date().toISOString()}
\`\`\`
`;
  writeFile(path.join(vault, '06-REPOSITORIES', 'shared-context.md'), context);

  log('Vault initialized!', C.g);
  log(\`  Path: \${vault}\`);
}

function getLocalFiles(src) {
  const files = [];
  if (!exists(src)) return files;
  
  const traverse = (dir, base = '') => {
    fs.readdirSync(dir).forEach(file => {
      const full = path.join(dir, file);
      const rel = path.join(base, file);
      if (isDir(full)) {
        traverse(full, rel);
      } else if (file.endsWith('.md')) {
        files.push(rel);
      }
    });
  };
  traverse(src);
  return files;
}

function syncPush(vault) {
  log('Pushing local → Obsidian...', C.m);
  
  LOCAL_ARTIFACTS.forEach(({ src, dest }) => {
    const srcPath = path.join(PROJECT_ROOT, src);
    const destPath = path.join(vault, dest);
    
    if (!exists(srcPath)) {
      warn(\`Skipping (not found): \${src}\`);
      return;
    }
    
    mkdir(destPath);
    const files = getLocalFiles(srcPath);
    
    files.forEach(file => {
      const srcFile = path.join(srcPath, file);
      const destFile = path.join(destPath, file);
      const content = readFile(srcFile);
      
      // Add Obsidian frontmatter if missing
      if (!content.startsWith('---')) {
        const frontmatter = \`---
project: "[[\${path.basename(PROJECT_ROOT)}]]"
type: \${src.replace(/\\/$/, '')}
source: local
synced: \${new Date().toISOString()}
---

\`;
        writeFile(destFile, frontmatter + content);
      } else {
        writeFile(destFile, content);
      }
    });
    
    info(\`  Synced \${files.length} files: \${src} → \${dest}\`);
  });
}

function syncPull(vault) {
  log('Pulling Obsidian → Local...', C.m);
  warn('Pull not implemented yet — use push for now');
}

function syncStatus(vault) {
  log('Sync Status', C.m);
  console.log(\`\\n  Vault: \${vault}\`);
  console.log(\`  Project: \${PROJECT_ROOT}\`);
  console.log('');

  LOCAL_ARTIFACTS.forEach(({ src }) => {
    const srcPath = path.join(PROJECT_ROOT, src);
    const count = exists(srcPath) ? getLocalFiles(srcPath).length : 0;
    const status = count > 0 ? \`\${C.g}✓\${C.reset} \${count} files\` : \`\${C.y}○\${C.reset} empty\`;
    console.log(\`    \${src.padEnd(15)} \${status}\`);
  });
}

const [,, cmd, vaultArg] = process.argv;
const vault = vaultArg || VAULT_PATH;

if (!vault) {
  error('Vault path required. Set OBSIDIAN_VAULT env or pass as argument.');
}

switch (cmd) {
  case 'init':
    initVault(vault);
    break;
  case 'push':
    syncPush(vault);
    break;
  case 'pull':
    syncPull(vault);
    break;
  case 'sync':
    syncPush(vault);
    break;
  case 'status':
    syncStatus(vault);
    break;
  default:
    console.log(\`
  Obsidian Sync

  Usage:
    node obsidian-sync.js init <vault>   Initialize vault
    node obsidian-sync.js push <vault>   Push local → vault
    node obsidian-sync.js pull <vault>   Pull vault → local
    node obsidian-sync.js sync <vault>   Full sync
    node obsidian-sync.js status <vault> Status

  Env: OBSIDIAN_VAULT=\${vault}
\`);
}
