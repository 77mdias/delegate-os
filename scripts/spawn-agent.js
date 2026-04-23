#!/usr/bin/env node
#===============================================================================
# AGENT SPAWNER — Delegado OS Sub-Agent Management
#===============================================================================
#
# Spawns specialized sub-agents for HELL phases.
#
# Usage:
#   node spawn-agent.js analyst <task> [context-file]
#   node spawn-agent.js coder <task> [context-file]
#   node spawn-agent.js review <task> [context-file]
#   node spawn-agent.js devops <task> [context-file]
#   node spawn-agent.js list
#
# For OpenClaw, use sessions_spawn tool directly.
# This script generates the task prompt and context.
#
#===============================================================================

const fs = require('fs');
const path = require('path');

const PROJECT_ROOT = path.resolve(__dirname, '..');
const SUBAGENTS_DIR = path.join(PROJECT_ROOT, 'subagents');
const KERNEL_DIR = path.join(PROJECT_ROOT, 'kernel');

const C = {
  r: '\x1b[0;31m', g: '\x1b[0;32m', y: '\x1b[1;33m',
  b: '\x1b[0;34m', c: '\x1b[0;36m', m: '\x1b[0;35m',
  bold: '\x1b[1m', reset: '\x1b[0m'
};

const log = (msg) => console.log(`${C.g}[SPAWNER]${C.reset} ${msg}`);
const info = (msg) => console.log(`${C.c}[INFO]${C.reset} ${msg}`);
const warn = (msg) => console.log(`${C.y}[WARN]${C.reset} ${msg}`);
const error = (msg) => { console.error(`${C.r}[ERROR]${C.reset} ${msg}`); process.exit(1); };

//-------------------------------------------------------------------------------
# Agent Spawner Script

Spawns specialized sub-agents for HELL method phases.

Usage:
  node spawn-agent.js list                    List available agents
  node spawn-agent.js analyst <task>         Spawn analyst agent
  node spawn-agent.js coder <task>           Spawn coder agent
  node spawn-agent.js review <task>          Spawn review agent
  node spawn-agent.js devops <task>          Spawn devops agent
  node spawn-agent.js spawn <type> <task>    Generic spawn

const fs = require('fs');
const path = require('path');

const PROJECT_ROOT = path.resolve(__dirname, '../..');
const KERNEL_DIR = path.join(PROJECT_ROOT, 'kernel');
const SUBAGENTS_DIR = path.join(PROJECT_ROOT, 'subagents');

const C = { r: '\x1b[0;31m', g: '\x1b[0;32m', y: '\x1b[1;33m', c: '\x1b[0;36m', m: '\x1b[0;35m', reset: '\x1b[0m' };

const log = (m) => console.log(\`\${C.g}[SPAWNER]\${C.reset} \${m}\`);
const info = (m) => console.log(\`\${C.c}[INFO]\${C.reset} \${m}\`);
const warn = (m) => console.log(\`\${C.y}[WARN]\${C.reset} \${m}\`);
const err = (m) => { console.error(\`\${C.r}[ERROR]\${C.reset} \${m}\`); process.exit(1); };

const AGENTS = {
  analyst: {
    name: 'Analyst Agent',
    hell_phase: 'SPEC',
    specialty: 'Requirements extraction, GRASP domain modeling',
    skills: ['ANALISE', 'PLANEJAMENTO'],
    template: 'ANALYST_PROMPT'
  },
  coder: {
    name: 'Coder Agent',
    hell_phase: 'TDD',
    specialty: 'TDD Red/Green/Refactor, GoF implementation',
    skills: ['EXECUCAO', 'QUALIDADE', 'DEVELOPMENT/tdd-cycle'],
    template: 'CODER_PROMPT'
  },
  review: {
    name: 'Review Agent',
    hell_phase: 'REFACTOR/REVIEW',
    specialty: 'GRASP/SOLID audit, GoF pattern application',
    skills: ['QUALIDADE', 'DEVELOPMENT/refactor'],
    template: 'REVIEW_PROMPT'
  },
  devops: {
    name: 'DevOps Agent',
    hell_phase: 'EVOLVE',
    specialty: 'CI/CD, tech debt tracking, deployment',
    skills: ['EXECUCAO'],
    template: 'DEVOPS_PROMPT'
  }
};

function loadContext(contextFile) {
  if (!contextFile) return {};
  try {
    return JSON.parse(fs.readFileSync(contextFile, 'utf8'));
  } catch {
    warn('Could not load context file');
    return {};
  }
}

function generatePrompt(agentType, task, context = {}) {
  const agent = AGENTS[agentType];
  if (!agent) err(\`Unknown agent type: \${agentType}\`);

  const hellCore = fs.readFileSync(path.join(KERNEL_DIR, 'hell', 'HELL-CORE-ENGINE.md'), 'utf8')
    .substring(0, 5000);

  return \`# HELL \${agent.hell_phase} Agent Task

## Agent Type: \${agent.name}
## HELL Phase: \${agent.hell_phase}
## Specialty: \${agent.specialty}

## Task
\${task}

## Project Context
\${context.projectName ? \`Project: \${context.projectName}\` : 'Project: (from working directory)'}
\${context.module ? \`Module: \${context.module}\` : ''}
\${context.specFile ? \`Spec: \${context.specFile}\` : ''}

## HELL CORE ENGINE (excerpt)
\${hellCore}

## Required Skills
\${agent.skills.map(s => \`- \${s}\`).join('\\n')}

## Instructions
1. Read relevant skills from \${KERNEL_DIR}/skills/
2. Execute HELL \${agent.hell_phase} phase
3. Follow HELL LOGIC GATE before any decision
4. Update/create artifacts in the project
5. Sync results to Obsidian vault if configured
6. Report completion with summary

## Output Format
When complete, report:
- Files created/modified
- HELL phase status
- Next recommended action
\`;
}

function spawnAgent(agentType, task, contextFile) {
  const agent = AGENTS[agentType];
  if (!agent) err(\`Unknown agent: \${agentType\}\`);

  log(\`Spawning \${agent.name}...\`);

  const context = loadContext(contextFile);
  const prompt = generatePrompt(agentType, task, context);

  // For OpenClaw: use sessions_spawn tool
  // This script generates the prompt for manual spawning
  console.log(\`
---
AGENT SPAWN REQUEST
Type: \${agentType}
Task: \${task}
Context: \${contextFile || 'none'}

PROMPT:
\${prompt}
---

To spawn this agent:
1. If using OpenClaw: Use sessions_spawn with the prompt above
2. If using Claude Code: Create a .claude/commands/ file
3. If manual: Copy the prompt to your agent

For programmatic spawning, integrate with your agent runtime's spawn API.
\`);
}

function listAgents() {
  console.log(\`
  \${C.bold}HELL Sub-Agents\${C.reset}

  Available agents:
\`);
  Object.entries(AGENTS).forEach(([key, agent]) => {
    console.log(\`    \${C.c}\${key.padEnd(10)}\${C.reset} \${agent.name}\`);
    console.log(\`                 HELL Phase: \${agent.hell_phase}\`);
    console.log(\`                 Specialty: \${agent.specialty}\`);
    console.log('');
  });
}

const [, , cmd, arg1, arg2, arg3] = process.argv;

switch (cmd) {
  case 'list':
    listAgents();
    break;
  case 'analyst':
  case 'coder':
  case 'review':
  case 'devops':
    if (!arg1) err(\`Task required: spawn-agent.js \${cmd} <task> [context-file]\`);
    spawnAgent(cmd, arg1, arg2);
    break;
  case 'spawn':
    if (!arg1 || !arg2) err('Usage: spawn-agent.js spawn <type> <task> [context-file]');
    spawnAgent(arg1, arg2, arg3);
    break;
  default:
    console.log(\`
  Agent Spawner

  Usage:
    node spawn-agent.js list                    List agents
    node spawn-agent.js analyst <task>         Analyst (SPEC)
    node spawn-agent.js coder <task>           Coder (TDD)
    node spawn-agent.js review <task>          Review (REFACTOR)
    node spawn-agent.js devops <task>          DevOps (EVOLVE)
    node spawn-agent.js spawn <type> <task>    Generic spawn

  Examples:
    node spawn-agent.js analyst "Create auth module spec"
    node spawn-agent.js coder "Run TDD on user module" context.json
\`);
}
