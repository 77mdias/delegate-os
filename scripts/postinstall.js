#!/usr/bin/env node
/**
 * Delegado OS - Postinstall Script
 * Auto-links the package and individual skills to AI agent skills directories.
 * 
 * Discovers ALL skills recursively under skills/dos/:
 *   skills/dos/help/         → ~/.claude/skills/dos-help
 *   skills/dos/hell/         → ~/.claude/skills/dos-hell
 *   skills/dos/hell/spec/    → ~/.claude/skills/dos-hell-spec
 *   skills/dos/hell/tdd/     → ~/.claude/skills/dos-hell-tdd
 *   ...etc
 */

import { existsSync, symlinkSync, mkdirSync, readdirSync, statSync, rmSync, readlinkSync, readFileSync, writeFileSync } from 'fs';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

// Detect supported AI agents and their skills directories
const AGENTS = {
  claude: { dir: '.claude/skills', name: 'Claude Code', type: 'symlink' },
  codex: { dir: '.codex/skills', name: 'GitHub Codex', type: 'symlink' },
  cursor: { dir: '.cursor/skills', name: 'Cursor', type: 'symlink' },
  agents: { dir: '.agents/skills', name: 'Agents Marketplace', type: 'marketplace' }
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
      if (stats.isSymbolicLink && stats.isSymbolicLink()) {
        try {
          const linkTarget = readlinkSync(target);
          if (linkTarget === source) {
            return 'already_linked';
          }
        } catch {}
        rmSync(target);
      } else if (existsSync(join(target, 'SKILL.md'))) {
        // Already exists as a real directory with SKILL.md — skip
        return 'already_linked';
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

/**
 * Add skill to .agents marketplace (.skill-lock.json)
 */
function addToMarketplaceLock(skillName, skillPath) {
  const lockPath = join(getHomeDir(), '.agents', '.skill-lock.json');
  if (!existsSync(lockPath)) {
    console.log(`  ⚠ .skill-lock.json not found, skipping marketplace`);
    return 'skip';
  }

  try {
    const lockContent = readFileSync(lockPath, 'utf-8');
    const lock = JSON.parse(lockContent);

    if (!lock.skills) lock.skills = {};

    lock.skills[skillName] = {
      source: '77mdias/delegate-os',
      sourceType: 'github',
      sourceUrl: 'https://github.com/77mdias/delegate-os.git',
      skillPath: skillPath,
      installedAt: new Date().toISOString(),
      updatedAt: new Date().toISOString()
    };

    writeFileSync(lockPath, JSON.stringify(lock, null, 2));
    return 'linked';
  } catch (err) {
    return 'error';
  }
}

/**
 * Recursively discover all skill directories under a given base path.
 * A directory is a skill if it contains a SKILL.md file.
 * 
 * Naming convention:
 *   Level 1: dos-{name}       (e.g. dos-hell, dos-bmad)
 *   Level 2+: parent:{name}   (e.g. dos-hell:spec, dos-hell:tdd)
 * 
 * @param {string} baseDir - Directory to scan
 * @param {string} prefix - Prefix for the skill name (e.g. 'dos')
 * @param {number} depth - Current recursion depth (0 = first level)
 * @returns {Array<{name: string, path: string}>} List of discovered skills
 */
function discoverSkills(baseDir, prefix, depth = 0) {
  const skills = [];
  
  if (!existsSync(baseDir)) return skills;
  
  const entries = readdirSync(baseDir);
  for (const entry of entries) {
    if (entry === 'SKILL.md' || entry.startsWith('.')) continue;
    
    const entryPath = join(baseDir, entry);
    const stats = statSync(entryPath);
    
    if (stats.isDirectory()) {
      // Level 0 uses '-' (dos-hell), deeper levels use ':' (dos-hell:spec)
      const separator = depth === 0 ? '-' : ':';
      const skillName = `${prefix}${separator}${entry}`;
      const hasSkill = existsSync(join(entryPath, 'SKILL.md'));
      
      if (hasSkill) {
        skills.push({ name: skillName, path: entryPath });
      }
      
      // Recurse into subdirectories for nested skills (e.g. hell/spec, hell/tdd)
      const subSkills = discoverSkills(entryPath, skillName, depth + 1);
      skills.push(...subSkills);
    }
  }
  
  return skills;
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
      ensureDir(skillsDir);
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

  // Root dos skill: skills/dos -> ~/.claude/skills/dos
  console.log('\n📦 Root skill:');
  const dosDir = join(skillsBase, 'dos');
  if (existsSync(dosDir)) {
    for (const [key, agent] of Object.entries(AGENTS)) {
      const skillsDir = join(homeDir, agent.dir);
      if (existsSync(skillsDir)) {
        const targetLink = join(skillsDir, 'dos');
        const result = linkIfNotExists(dosDir, targetLink);
        const icons = { linked: '✓', already_linked: '✓', exists_not_symlink: '⚠', error: '✗' };
        console.log(`${icons[result]} dos → ${agent.name}`);
      }
    }
  }

  // Discover and link ALL individual skills recursively
  console.log('\n📦 Individual skills (recursive):');
  if (existsSync(dosDir)) {
    const skills = discoverSkills(dosDir, 'dos');

    for (const skill of skills) {
      for (const [key, agent] of Object.entries(AGENTS)) {
        const skillsDir = join(homeDir, agent.dir);
        if (existsSync(skillsDir)) {
          if (agent.type === 'marketplace') {
            // For marketplace, add to .skill-lock.json instead of symlink
            const skillPathInPackage = skill.path.replace(packagePath + '/', '');
            const result = addToMarketplaceLock(skill.name, `${skillPathInPackage}/SKILL.md`);
            if (result === 'linked') {
              console.log(`  ✓ ${skill.name} (marketplace)`);
            }
          } else {
            const targetLink = join(skillsDir, skill.name);
            const result = linkIfNotExists(skill.path, targetLink);
            const icons = { linked: '✓', already_linked: '✓', exists_not_symlink: '⚠', error: '✗' };
            if (result === 'linked') {
              console.log(`  ${icons[result]} ${skill.name}`);
            }
          }
        }
      }
    }

    console.log(`\n  Total: ${skills.length} skills discovered`);
  }

  console.log('\n🚀 Skills installed! Commands available:');
  console.log('   /dos, /dos-bmad, /dos-hell, /dos-hell-spec, /dos-hell-tdd, etc.');
  console.log('   Run /dos-help for the full command reference.\n');
}

main();
