/**
 * DELEGADO OS — Test Suite
 * 
 * Tests for meta-prompting, HELL cycles, and memory system.
 */

const fs = require('fs');
const path = require('path');

const PROJECT_ROOT = path.resolve(__dirname, '..');

// Colors
const C = { g: '\x1b[0;32m', r: '\x1b[0;31m', y: '\x1b[1;33m', c: '\x1b[0;36m', m: '\x1b[0;35m', bold: '\x1b[1m', reset: '\x1b[0m' };

// Results tracking
const results = { passed: 0, failed: 0 };

// Test utilities
const assert = (condition, message) => {
  if (!condition) throw new Error(`Assertion failed: ${message}`);
};

const test = (name, fn) => {
  try {
    fn();
    console.log(`  ${C.g}✅${C.reset} ${name}`);
    results.passed++;
    return true;
  } catch (e) {
    console.error(`  ${C.r}❌${C.reset} ${name}`);
    console.error(`     ${e.message}`);
    results.failed++;
    return false;
  }
};

// describe wrapper for Jest compatibility in plain Node
const describe = (name, fn) => {
  console.log(`\n${C.bold}${name}${C.reset}`);
  fn();
};

//------------------------------------------------------------------------------
// Meta-Prompting Tests
//------------------------------------------------------------------------------

describe('Meta-Prompting', () => {
  const metaPromptingFile = path.join(PROJECT_ROOT, 'META-PROMPTING.md');
  
  test('META-PROMPTING.md exists', () => {
    assert(fs.existsSync(metaPromptingFile), 'META-PROMPTING.md not found');
  });
  
  test('Contains HELL philosophy', () => {
    const content = fs.readFileSync(metaPromptingFile, 'utf8');
    assert(content.includes('HELL IS THE CENTER'), 'HELL philosophy missing');
    assert(content.includes('OBSIDIAN IS THE BRAIN'), 'Obsidian philosophy missing');
    assert(content.includes('AUTOMATION WITHOUT WAITING'), 'Automation philosophy missing');
  });
  
  test('Contains autonomous agent loop', () => {
    const content = fs.readFileSync(metaPromptingFile, 'utf8');
    assert(content.includes('RECEIVE'), 'Agent loop RECEIVE missing');
    assert(content.includes('ANALYZE'), 'Agent loop ANALYZE missing');
    assert(content.includes('EXECUTE'), 'Agent loop EXECUTE missing');
    assert(content.includes('LEARN'), 'Agent loop LEARN missing');
  });
  
  test('Contains skill auto-loading rules', () => {
    const content = fs.readFileSync(metaPromptingFile, 'utf8');
    assert(content.includes('Skill Auto-Loading'), 'Skill auto-loading section missing');
    assert(content.includes('ANALISE'), 'ANALISE skill trigger missing');
    assert(content.includes('EXECUCAO'), 'EXECUCAO skill trigger missing');
    assert(content.includes('HELL'), 'HELL skill trigger missing');
  });
  
  test('Contains Obsidian sync triggers', () => {
    const content = fs.readFileSync(metaPromptingFile, 'utf8');
    assert(content.includes('Obsidian Sync Triggers'), 'Sync triggers section missing');
    assert(content.includes('hell-spec.md') && content.includes('created'), 'Spec creation trigger missing');
    assert(content.includes('TDD cycle completed'), 'TDD completion trigger missing');
  });
});

//------------------------------------------------------------------------------
// HELL CORE ENGINE Tests
//------------------------------------------------------------------------------

describe('HELL CORE ENGINE', () => {
  const hellCoreFile = path.join(PROJECT_ROOT, 'kernel', 'hell', 'HELL-CORE-ENGINE.md');
  
  test('HELL-CORE-ENGINE.md exists', () => {
    assert(fs.existsSync(hellCoreFile), 'HELL CORE ENGINE not found');
  });
  
  test('Contains HELL LOGIC GATE', () => {
    const content = fs.readFileSync(hellCoreFile, 'utf8');
    assert(content.includes('HELL LOGIC GATE'), 'HELL LOGIC GATE missing');
    assert(content.includes('INFORMATION EXPERT'), 'INFORMATION EXPERT missing');
    assert(content.includes('PROTECTED VARIATIONS'), 'PROTECTED VARIATIONS missing');
  });
  
  test('Contains GRASP patterns', () => {
    const content = fs.readFileSync(hellCoreFile, 'utf8');
    const patterns = ['Information Expert', 'Creator', 'Controller', 'Low Coupling', 'High Cohesion'];
    patterns.forEach(p => {
      assert(content.includes(p), `GRASP pattern ${p} missing`);
    });
  });
  
  test('Contains GoF patterns', () => {
    const content = fs.readFileSync(hellCoreFile, 'utf8');
    const patterns = ['Strategy', 'Factory Method', 'Observer', 'Repository', 'Singleton'];
    patterns.forEach(p => {
      assert(content.includes(p), `GoF pattern ${p} missing`);
    });
  });
  
  test('Contains SOLID principles', () => {
    const content = fs.readFileSync(hellCoreFile, 'utf8');
    const principles = ['SRP', 'OCP', 'LSP', 'ISP', 'DIP'];
    principles.forEach(p => {
      assert(content.includes(p), `SOLID principle ${p} missing`);
    });
  });
  
  test('Contains Architecture Layers', () => {
    const content = fs.readFileSync(hellCoreFile, 'utf8');
    assert(content.includes('PRESENTATION'), 'PRESENTATION layer missing');
    assert(content.includes('APPLICATION'), 'APPLICATION layer missing');
    assert(content.includes('DOMAIN'), 'DOMAIN layer missing');
    assert(content.includes('INFRASTRUCTURE'), 'INFRASTRUCTURE layer missing');
  });
  
  test('Gate validation checklist present', () => {
    const content = fs.readFileSync(hellCoreFile, 'utf8');
    assert(content.includes('Gate Validation Checklist'), 'Gate checklist missing');
    assert(content.includes('TESTE'), 'TESTE criterion missing');
    assert(content.includes('PADRÃO'), 'PADRÃO criterion missing');
  });
});

//------------------------------------------------------------------------------
// HELL Templates Tests
//------------------------------------------------------------------------------

describe('HELL Templates', () => {
  const templatesDir = path.join(PROJECT_ROOT, 'templates', 'hell');
  
  test('templates/hell directory exists', () => {
    assert(fs.existsSync(templatesDir), 'templates/hell not found');
  });
  
  test('hell-spec template exists', () => {
    const files = fs.readdirSync(templatesDir);
    assert(files.some(f => f.includes('hell-spec')), 'hell-spec template missing');
  });
  
  test('hell-tdd-log template exists', () => {
    const files = fs.readdirSync(templatesDir);
    assert(files.some(f => f.includes('hell-tdd-log')), 'hell-tdd-log template missing');
  });
  
  test('hell-refactor template exists', () => {
    const files = fs.readdirSync(templatesDir);
    assert(files.some(f => f.includes('hell-refactor')), 'hell-refactor template missing');
  });
  
  test('hell-adr template exists', () => {
    const files = fs.readdirSync(templatesDir);
    assert(files.some(f => f.includes('hell-adr')), 'hell-adr template missing');
  });
  
  test('hell-milestone template exists', () => {
    const files = fs.readdirSync(templatesDir);
    assert(files.some(f => f.includes('hell-milestone')), 'hell-milestone template missing');
  });
});

//------------------------------------------------------------------------------
// Skills Tests
//------------------------------------------------------------------------------

describe('Skills', () => {
  const skillsDir = path.join(PROJECT_ROOT, 'kernel', 'skills');
  
  test('kernel/skills directory exists', () => {
    assert(fs.existsSync(skillsDir), 'kernel/skills not found');
  });
  
  test('Core skills exist', () => {
    const coreSkills = ['ANALISE', 'EXECUCAO', 'PLANEJAMENTO', 'QUALIDADE', 'SETUP'];
    coreSkills.forEach(skill => {
      const skillPath = path.join(skillsDir, skill);
      assert(fs.existsSync(skillPath), `Skill ${skill} not found`);
    });
  });
  
  test('DEVELOPMENT sub-skills exist', () => {
    const devSkills = ['bugfix.md', 'feature-delivery.md', 'tdd-cycle.md', 'refactor.md'];
    devSkills.forEach(skill => {
      const skillPath = path.join(skillsDir, 'DEVELOPMENT', skill);
      assert(fs.existsSync(skillPath), `DEVELOPMENT/${skill} not found`);
    });
  });
});

//------------------------------------------------------------------------------
// Workflows Tests
//------------------------------------------------------------------------------

describe('Workflows', () => {
  const workflowsDir = path.join(PROJECT_ROOT, 'workflows');
  
  test('workflows directory exists', () => {
    assert(fs.existsSync(workflowsDir), 'workflows not found');
  });
  
  test('BMAD workflow exists', () => {
    assert(fs.existsSync(path.join(workflowsDir, 'bmad.yml')), 'bmad.yml missing');
  });
  
  test('HELL milestone workflow exists', () => {
    assert(fs.existsSync(path.join(workflowsDir, 'hell-milestone.yml')), 'hell-milestone.yml missing');
  });
  
  test('GSD workflow exists', () => {
    assert(fs.existsSync(path.join(workflowsDir, 'fase.yml')), 'fase.yml missing');
  });
});

//------------------------------------------------------------------------------
// CLI Tests
//------------------------------------------------------------------------------

describe('Delegado CLI', () => {
  const cliFile = path.join(PROJECT_ROOT, 'delegado.sh');
  
  test('delegado.sh exists', () => {
    assert(fs.existsSync(cliFile), 'delegado.sh not found');
  });
  
  test('delegado.sh is executable', () => {
    const stats = fs.statSync(cliFile);
    const isExecutable = (stats.mode & 0o111) !== 0;
    assert(isExecutable, 'delegado.sh not executable');
  });
  
  test('delegado.sh contains HELL commands', () => {
    const content = fs.readFileSync(cliFile, 'utf8');
    // Check if HELL-related scripts exist and are referenced
    const hellScriptExists = fs.existsSync(path.join(PROJECT_ROOT, 'scripts', 'hell', 'hell-cycle.js'));
    assert(hellScriptExists, 'scripts/hell/hell-cycle.js not found');
  });
});

//------------------------------------------------------------------------------
// Obsidian Integration Tests
//------------------------------------------------------------------------------

describe('Obsidian Integration', () => {
  const obsidianScriptsDir = path.join(PROJECT_ROOT, 'scripts', 'obsidian');
  const obsidianTemplatesDir = path.join(PROJECT_ROOT, 'templates', 'obsidian');
  
  test('Obsidian scripts directory exists', () => {
    assert(fs.existsSync(obsidianScriptsDir), 'scripts/obsidian not found');
  });
  
  test('Obsidian sync script exists', () => {
    const syncScript = path.join(obsidianScriptsDir, 'obsidian-sync.js');
    assert(fs.existsSync(syncScript), 'obsidian-sync.js not found');
  });
  
  test('Obsidian templates directory exists', () => {
    assert(fs.existsSync(obsidianTemplatesDir), 'templates/obsidian not found');
  });
});

//------------------------------------------------------------------------------
// Summary
//------------------------------------------------------------------------------

console.log(`\n${C.bold}═══ RESULTS ═══${C.reset}`);
console.log(`  ${C.g}Passed: ${results.passed}${C.reset}`);
console.log(`  ${results.failed > 0 ? C.r : C.g}Failed: ${results.failed}${C.reset}`);

process.exit(results.failed > 0 ? 1 : 0);
