#!/usr/bin/env node
/**
 * Delegado OS - Postinstall Script
 * Auto-links the package and individual skills to AI agent skills directories
 */

import { existsSync, symlinkSync, mkdirSync, readdirSync, statSync, rmSync } from 'fs';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

// Detect supported AI agents and their skills directories
const AGENTS = {
  claude: { dir: '.claude/skills', name: 'Claude Code' },
  codex: { dir: '.codex/skills', name: 'GitHub Codex' },
  cursor: { dir: '.cursor/skills', name: 'Cursor' }
};

function getHomeDir() {
  return process.env.HOME || process.env.USERPROFILE || '/tmp';
}

function ensureDir(dir) {
  if (!existsSync(dir)) {
    mkdirSync(dir, { recursive: true });
  }
}

function linkIfNotExists(source, target) {
  if (existsSync(target)) {
    try {
      const stats = statSync(target);
      if (stats.isSymbolicLink()) {
        const linkTarget = readlinkSync(target);
        if (linkTarget === source) {
          return 'already_linked';
        }
        rmSync(target);
      } else {
        return 'exists_not_symlink';
      }
    } catch {
      return 'error';
    }
  }
  try {
    symlinkSync(source, target);
    return 'linked';
  } catch (err) {
    return 'error';
  }
}

function main() {
  const packagePath = join(__dirname, '..');
  const skillsBase = join(packagePath, 'skills');
  const homeDir = getHomeDir();

  console.log('\n🖥️  Delegado OS - Postinstall\n');
  console.log(`📦 Package: ${packagePath}\n`);

  // Link package to each agent's skills dir
  console.log('📦 Package links:');
  for (const [key, agent] of Object.entries(AGENTS)) {
    const skillsDir = join(homeDir, agent.dir);
    if (existsSync(skillsDir) || process.argv.includes('--force')) {
      const targetLink = join(skillsDir, 'delegado-os');
      const result = linkIfNotExists(packagePath, targetLink);
      const icons = { linked: '✓', already_linked: '✓', exists_not_symlink: '⚠', error: '✗' };
      const messages = {
        linked: `Linked to ${targetLink}`,
        already_linked: 'Already linked',
        exists_not_symlink: 'Exists (not symlink)',
        error: 'Failed'
      };
      console.log(`${icons[result]} ${agent.name}: ${messages[result]}`);
    }
  }

  // Link individual skills: skills/dos/[name] -> ~/.claude/skills/dos-[name]
  console.log('\n📦 Individual skills:');
  if (existsSync(skillsBase)) {
    const dosDir = join(skillsBase, 'dos');
    if (existsSync(dosDir)) {
      const entries = readdirSync(dosDir);
      for (const entry of entries) {
        const entryPath = join(dosDir, entry);
        const stats = statSync(entryPath);
        if (stats.isDirectory()) {
          const targetLink = join(homeDir, '.claude/skills', `dos-${entry}`);
          const result = linkIfNotExists(entryPath, targetLink);
          const icons = { linked: '✓', already_linked: '✓', exists_not_symlink: '⚠', error: '✗' };
          console.log(`${icons[result]} dos-${entry}: Linked`);
        }
      }
    }
  }

  console.log('\n🚀 Skills installed! Commands available:');
  console.log('   /dos, /dos-bmad, /dos-help, /dos-propose, /dos-specs, etc.\n');
}

main();
