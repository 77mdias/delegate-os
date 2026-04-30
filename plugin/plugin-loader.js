/**
 * DELEGADO OS — Plugin System
 * 
 * Plugin loader and registry for extending Delegado OS.
 * 
 * Usage:
 *   node plugin/plugin-loader.js list          List plugins
 *   node plugin/plugin-loader.js install <pkg> Install plugin
 *   node plugin/plugin-loader.js load <name>   Load plugin
 *   node plugin/plugin-loader.js unload <name> Unload plugin
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const PROJECT_ROOT = path.resolve(__dirname, '..');
const PLUGIN_DIR = path.join(PROJECT_ROOT, 'plugin');
const REGISTRY_FILE = path.join(PLUGIN_DIR, 'registry.json');

const C = {
  r: '\x1b[0;31m', g: '\x1b[0;32m', y: '\x1b[1;33m',
  b: '\x1b[0;34m', c: '\x1b[0;36m', m: '\x1b[0;35m',
  bold: '\x1b[1m', reset: '\x1b[0m'
};

const log = (m) => console.log(`${C.g}[PLUGIN]${C.reset} ${m}`);
const info = (m) => console.log(`${C.c}[INFO]${C.reset} ${m}`);
const warn = (m) => console.log(`${C.y}[WARN]${C.reset} ${m}`);
const error = (m) => { console.error(`${C.r}[ERROR]${C.reset} ${m}`); process.exit(1); };

const readJSON = (f) => { try { return JSON.parse(fs.readFileSync(f, 'utf8')); } catch { return {}; } };
const writeJSON = (f, d) => fs.writeFileSync(f, JSON.stringify(d, null, 2), 'utf8');

function ensurePluginDir() {
  const pluginsDir = path.join(PLUGIN_DIR, 'plugins');
  if (!fs.existsSync(pluginsDir)) {
    fs.mkdirSync(pluginsDir, { recursive: true });
    info(`Created: ${pluginsDir}`);
  }
  if (!fs.existsSync(REGISTRY_FILE)) {
    writeJSON(REGISTRY_FILE, { version: '1.0.0', plugins: [] });
    info(`Created registry: ${REGISTRY_FILE}`);
  }
}

function listPlugins() {
  ensurePluginDir();
  const registry = readJSON(REGISTRY_FILE);
  
  console.log(`\n${C.bold}═══ DELEGADO PLUGINS ═══${C.reset}`);
  console.log(`Registry: ${REGISTRY_FILE}`);
  console.log(`Total: ${registry.plugins.length}`);
  console.log('');
  
  if (registry.plugins.length === 0) {
    warn('No plugins installed');
    console.log('');
    console.log('To install a plugin:');
    console.log('  node plugin-loader.js install <plugin-name>');
    return;
  }
  
  registry.plugins.forEach(p => {
    const status = p.enabled ? `${C.g}enabled${C.reset}` : `${C.y}disabled${C.reset}`;
    console.log(`  ${C.c}${p.name}${C.reset} - ${p.description} [${status}]`);
    console.log(`    Version: ${p.version}`);
    console.log(`    Path: ${p.path}`);
    console.log('');
  });
}

function loadPlugin(name) {
  ensurePluginDir();
  const registry = readJSON(REGISTRY_FILE);
  const plugin = registry.plugins.find(p => p.name === name);
  
  if (!plugin) {
    error(`Plugin not found: ${name}`);
  }
  
  if (!plugin.enabled) {
    warn(`Plugin disabled: ${name}`);
    return;
  }
  
  const pluginPath = path.join(PLUGIN_DIR, 'plugins', name);
  const indexFile = path.join(pluginPath, 'index.js');
  
  if (!fs.existsSync(indexFile)) {
    error(`Plugin entry point not found: ${indexFile}`);
  }
  
  log(`Loading plugin: ${name}`);
  
  try {
    const plugin = require(indexFile);
    info(`Plugin ${name} loaded successfully`);
    
    if (plugin.activate) {
      plugin.activate();
    }
    
    if (plugin.commands) {
      console.log(`\n${C.bold}Commands provided by ${name}:${C.reset}`);
      Object.entries(plugin.commands).forEach(([cmd, desc]) => {
        console.log(`  ${C.c}${cmd}${C.reset} - ${desc}`);
      });
    }
    
    if (plugin.skills) {
      console.log(`\n${C.bold}Skills provided by ${name}:${C.reset}`);
      plugin.skills.forEach(skill => {
        console.log(`  ${C.c}${skill}${C.reset}`);
      });
    }
    
  } catch (e) {
    error(`Failed to load plugin: ${e.message}`);
  }
}

function installPlugin(pkg) {
  ensurePluginDir();
  
  log(`Installing plugin: ${pkg}`);
  
  const pluginPath = path.join(PLUGIN_DIR, 'plugins', pkg);
  
  if (fs.existsSync(pluginPath)) {
    warn(`Plugin already exists: ${pkg}`);
    return;
  }
  
  // For npm packages
  if (pkg.startsWith('@')) {
    info(`Installing from npm: ${pkg}`);
    try {
      execSync(`npm install ${pkg}`, { cwd: PLUGIN_DIR, stdio: 'inherit' });
    } catch {
      error(`Failed to install: ${pkg}`);
    }
    return;
  }
  
  // For git repos
  if (pkg.includes('github.com') || pkg.includes('gitlab.com')) {
    info(`Cloning from git: ${pkg}`);
    try {
      execSync(`git clone ${pkg} ${pluginPath}`, { stdio: 'inherit' });
    } catch {
      error(`Failed to clone: ${pkg}`);
    }
    return;
  }
  
  error(`Unknown package format: ${pkg}`);
}

function uninstallPlugin(name) {
  ensurePluginDir();
  const registry = readJSON(REGISTRY_FILE);
  const idx = registry.plugins.findIndex(p => p.name === name);
  
  if (idx === -1) {
    error(`Plugin not found: ${name}`);
  }
  
  registry.plugins.splice(idx, 1);
  writeJSON(REGISTRY_FILE, registry);
  
  const pluginPath = path.join(PLUGIN_DIR, 'plugins', name);
  if (fs.existsSync(pluginPath)) {
    fs.rmSync(pluginPath, { recursive: true });
    log(`Removed plugin: ${name}`);
  }
}

function enablePlugin(name) {
  ensurePluginDir();
  const registry = readJSON(REGISTRY_FILE);
  const plugin = registry.plugins.find(p => p.name === name);
  
  if (!plugin) error(`Plugin not found: ${name}`);
  
  plugin.enabled = true;
  writeJSON(REGISTRY_FILE, registry);
  log(`Enabled plugin: ${name}`);
}

function disablePlugin(name) {
  ensurePluginDir();
  const registry = readJSON(REGISTRY_FILE);
  const plugin = registry.plugins.find(p => p.name === name);
  
  if (!plugin) error(`Plugin not found: ${name}`);
  
  plugin.enabled = false;
  writeJSON(REGISTRY_FILE, registry);
  log(`Disabled plugin: ${name}`);
}

function createPlugin(name) {
  ensurePluginDir();
  
  const pluginPath = path.join(PLUGIN_DIR, 'plugins', name);
  
  if (fs.existsSync(pluginPath)) {
    error(`Plugin already exists: ${name}`);
  }
  
  fs.mkdirSync(pluginPath, { recursive: true });
  fs.mkdirSync(path.join(pluginPath, 'skills'), { recursive: true });
  
  // Create plugin.json
  const pluginJson = {
    name,
    version: '1.0.0',
    description: `${name} plugin for Delegado OS`,
    author: 'Delegado OS',
    HellPhase: null,
    commands: {},
    skills: []
  };
  
  fs.writeFileSync(
    path.join(pluginPath, 'plugin.json'),
    JSON.stringify(pluginJson, null, 2),
    'utf8'
  );
  
  // Create index.js
  const indexJs = `/**
 * ${name} Plugin for Delegado OS
 */

module.exports = {
  name: '${name}',
  version: '1.0.0',
  
  activate() {
    console.log('[${name}] Plugin activated');
  },
  
  commands: {
    // Add commands here
    // '${name}:do-something': 'Do something',
  },
  
  skills: [
    // Add skills here
    // '${name}/SKILL-NAME',
  ]
};
`;
  
  fs.writeFileSync(path.join(pluginPath, 'index.js'), indexJs, 'utf8');
  
  // Create SKILL.md template
  const skillMd = `# ${name} SKILL

Plugin skill for ${name}

## Description

Describe what this skill does.

## Usage

Describe how to use this skill.

## Triggers

-
`;
  
  fs.writeFileSync(path.join(pluginPath, 'skills', 'SKILL.md'), skillMd, 'utf8');
  
  // Register plugin
  const registry = readJSON(REGISTRY_FILE);
  registry.plugins.push({
    name,
    version: '1.0.0',
    description: `${name} plugin`,
    path: pluginPath,
    enabled: true,
    installed: new Date().toISOString()
  });
  writeJSON(REGISTRY_FILE, registry);
  
  log(`Created plugin: ${name}`);
  log(`Path: ${pluginPath}`);
}

function initPluginSystem() {
  ensurePluginDir();
  
  const templatesDir = path.join(PLUGIN_DIR, 'templates');
  if (!fs.existsSync(templatesDir)) {
    fs.mkdirSync(templatesDir, { recursive: true });
    
    // Create template
    const template = `# Plugin Template

## Structure

\`\`\`
my-plugin/
├── plugin.json
├── index.js
└── skills/
    └── SKILL.md
\`\`\`

## plugin.json

\`\`\`json
{
  "name": "my-plugin",
  "version": "1.0.0",
  "description": "My plugin",
  "HellPhase": "SPEC|TDD|REFACTOR|EVOLVE|REVIEW|null",
  "commands": {
    "my:command": "Description"
  },
  "skills": [
    "my-plugin/SKILL-NAME"
  ]
}
\`\`\`

## index.js

\`\`\`javascript
module.exports = {
  activate() { /* called on load */ },
  deactivate() { /* called on unload */ },
  commands: {},
  skills: []
};
\`\`\`
`;
    
    fs.writeFileSync(path.join(templatesDir, 'README.md'), template, 'utf8');
  }
  
  log('Plugin system initialized');
}

// Main
const [, , cmd, arg1, arg2] = process.argv;

switch (cmd) {
  case 'init':
    initPluginSystem();
    break;
  case 'list':
    listPlugins();
    break;
  case 'load':
    if (!arg1) error('Plugin name required');
    loadPlugin(arg1);
    break;
  case 'install':
    if (!arg1) error('Package required');
    installPlugin(arg1);
    break;
  case 'uninstall':
    if (!arg1) error('Plugin name required');
    uninstallPlugin(arg1);
    break;
  case 'enable':
    if (!arg1) error('Plugin name required');
    enablePlugin(arg1);
    break;
  case 'disable':
    if (!arg1) error('Plugin name required');
    disablePlugin(arg1);
    break;
  case 'create':
    if (!arg1) error('Plugin name required');
    createPlugin(arg1);
    break;
  default:
    console.log(`
  Delegado OS Plugin System

  Usage:
    node plugin-loader.js init              Initialize plugin system
    node plugin-loader.js list               List installed plugins
    node plugin-loader.js load <name>        Load a plugin
    node plugin-loader.js install <pkg>      Install a plugin
    node plugin-loader.js uninstall <name>   Uninstall a plugin
    node plugin-loader.js enable <name>       Enable a plugin
    node plugin-loader.js disable <name>      Disable a plugin
    node plugin-loader.js create <name>       Create a new plugin

  Examples:
    node plugin-loader.js list
    node plugin-loader.js install @delegado/my-plugin
    node plugin-loader.js create my-plugin
`);
}
