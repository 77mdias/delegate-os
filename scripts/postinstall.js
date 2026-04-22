#!/usr/bin/env node
/**
 * Delegado OS - Postinstall Script
 * Auto-links the package to AI agent skills directories
 */

import { existsSync, symlinkSync, mkdirSync, readdirSync, statSync, rmSync } from 'fs';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

// Detect supported AI agents and their skills directories
const AGENTS = {
  claude: {
    dir: '.claude/skills',
    name: 'Claude Code',
    skillDir: 'delegado-os'
  },
  codex: {
    dir: '.codex/skills',
    name: 'GitHub Codex',
    skillDir: 'delegado-os'
  },
  cursor: {
    dir: '.cursor/skills',
    name: 'Cursor',
    skillDir: 'delegado-os'
  }
};

function getHomeDir() {
  return process.env.HOME || process.env.USERPROFILE || '/tmp';
}

function ensureDir(dir) {
  if (!existsSync(dir)) {
    mkdirSync(dir, { recursive: true });
  }
}

function isAlreadyLinked(source, target) {
  try {
    if (existsSync(target)) {
      const stats = statSync(target);
      if (stats.isSymbolicLink()) {
        const linkTarget = readlinkSync(target);
        return linkTarget === source || linkTarget === source.replace(/\/+$/, '');
      }
      return false;
    }
  } catch {
    return false;
  }
  return false;
}

function linkPackage(agentKey, agent, packagePath) {
  const homeDir = getHomeDir();
  const skillsDir = join(homeDir, agent.dir);
  const targetLink = join(skillsDir, agent.skillDir);

  ensureDir(skillsDir);

  // Check if already linked
  if (isAlreadyLinked(packagePath, targetLink)) {
    console.log(`✓ ${agent.name}: Already linked`);
    return { agent: agent.name, status: 'already_linked', path: targetLink };
  }

  // Remove existing if not a symlink to our package
  if (existsSync(targetLink)) {
    try {
      rmSync(targetLink, { force: true });
    } catch {
      console.log(`⚠ ${agent.name}: Could not remove existing path`);
      return { agent: agent.name, status: 'skipped', path: targetLink };
    }
  }

  try {
    symlinkSync(packagePath, targetLink);
    console.log(`✓ ${agent.name}: Linked to ${targetLink}`);
    return { agent: agent.name, status: 'linked', path: targetLink };
  } catch (err) {
    console.log(`✗ ${agent.name}: Failed - ${err.message}`);
    return { agent: agent.name, status: 'error', error: err.message };
  }
}

function main() {
  const packagePath = join(__dirname, '..');
  const homeDir = getHomeDir();

  console.log('\n🖥️  Delegado OS - Postinstall\n');
  console.log(`📦 Package: ${packagePath}\n`);

  const results = [];
  let linked = 0;

  for (const [key, agent] of Object.entries(AGENTS)) {
    const skillsDir = join(homeDir, agent.dir);
    if (existsSync(skillsDir) || process.argv.includes('--force')) {
      const result = linkPackage(key, agent, packagePath);
      results.push(result);
      if (result.status === 'linked') linked++;
    } else {
      console.log(`○ ${agent.name}: Not detected (skipped)`);
    }
  }

  console.log('\n📋 Summary');
  console.log(`   Linked to ${linked} agent(s)\n`);

  if (linked > 0) {
    console.log('🚀 Run `delegado --version` to verify installation\n');
  }

  // Print troubleshooting tips if nothing was linked
  if (linked === 0) {
    console.log('💡 Manual linking:');
    console.log('   mkdir -p ~/.claude/skills && ln -s', packagePath, '~/.claude/skills/delegado-os\n');
  }
}

main();
