---
name: dos-hell:obsidian-graph
description: "Vault analytics — backlink graph, tag network, orphans | /dos-hell:obsidian-graph [stats|orphans|clusters|export|compare]"
argument-hint: "[stats|orphans|clusters|export|compare]"
allowed-tools:
  - Read
  - Write
  - Bash
  - Glob
  - Grep
  - Edit
---

<objective>
HELL Obsidian Graph — Knowledge Graph Analytics

"Visualize the web of knowledge. Find the gaps."

Analyzes vault structure, finds orphans, maps clusters, exports graph data.
</objective>

<context>
## Graph Operations

### Vault Statistics
```bash
obsidian eval code="
const files = app.vault.getFiles();
const links = app.metadataCache.getLinks();
const tags = app.metadataCache.getTags();
console.log(JSON.stringify({
  totalFiles: files.length,
  totalLinks: links.length,
  totalTags: Object.keys(tags).length,
  folders: [...new Set(files.map(f => f.parent?.path))].length
}));
"
```

### Orphan Detection
```bash
obsidian search query="NOT [[" limit=100
```

### Tag Clusters
```bash
obsidian tags sort=count counts
```

### Backlink Graph
```bash
obsidian eval code="
const graph = {};
app.vault.getFiles().forEach(f => {
  const links = app.metadataCache.getBacklinks(f.path);
  graph[f.path] = links.map(l => l.path);
});
console.log(JSON.stringify(graph));
"
```

## Graph Export

```bash
# Export for visualization
obsidian eval code="
const data = {
  nodes: app.vault.getFiles().map(f => ({id: f.path, name: f.name})),
  edges: app.metadataCache.getLinks().map(l => ({source: l.link.path, target: l.target.path}))
};
console.log(JSON.stringify(data));
"
```

## Analytics Metrics

| Metric | Purpose |
|--------|---------|
| File count | Vault size |
| Link density | Knowledge interconnectedness |
| Orphan count | Isolated knowledge |
| Tag distribution | Topic coverage |
| Daily notes | Activity trends |
</context>

<process>
Route to appropriate sub-operation:

- stats → Vault statistics overview
- orphans → Find unlinked files
- clusters → Find topic clusters
- export → Export graph data (JSON/CSV)
- compare → Compare graph states

## HELL Logic Gate

1. **Information Expert** — What metric?
2. **Pure Fabrication** — Aggregation needed?
3. **Protected Variations** — Threshold for orphan?
4. **Indirection** — Direct query or export?
5. **Polymorphism** — Single file or batch?
</process>

<rules>
- Run stats weekly to track vault health
- Archive orphans with links or delete
- Export graph monthly for backup
- Tag taxonomy should evolve with clusters
- Compare before and after major changes
</rules>