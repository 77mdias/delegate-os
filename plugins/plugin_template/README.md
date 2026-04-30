# Plugin Template for Delegado OS

Use this as a starting point for creating your own plugin.

## Structure

```
plugin-template/
├── plugin.json      # Plugin manifest
├── README.md        # Plugin documentation
├── hooks.d/         # Custom hooks
│   └── pre_example.sh
├── modes/           # Custom agent modes
│   └── EXAMPLE/
│       └── SKILL.md
└── scripts/         # Custom scripts
    └── example_tool.sh
```

## Quick Start

1. Copy this directory: `cp -r plugins/plugin-template plugins/my-plugin`
2. Edit `plugin.json` with your details
3. Add your hooks, modes, and scripts
4. Install: `./scripts/delegado-ctl.sh plugin install ./plugins/my-plugin`

## Example: Adding a Custom Mode

1. Create `modes/MYMODE/SKILL.md` with your agent definition
2. Add `"MYMODE"` to the `modes` array in `plugin.json`
3. Add hook files in `hooks.d/` if needed
4. Test: `./scripts/delegate.sh activate MYMODE`
