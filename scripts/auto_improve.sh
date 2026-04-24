#!/bin/bash
#===============================================================================
# Delegado OS - Auto-Improve Script
# Analyzes and self-improves prompts, skills, and workflows
#===============================================================================

set -e

DELEGADO_ROOT="${DELEGADO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
ANALYSIS_DIR="$DELEGADO_ROOT/.delegado/analysis"

mkdir -p "$ANALYSIS_DIR"

#-------------------------------------------------------------------------------
# Color Output
#-------------------------------------------------------------------------------
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() { echo -e "${GREEN}[AUTO-IMPROVE]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1" >&2; }

#-------------------------------------------------------------------------------
# Analyze Skill Files
#-------------------------------------------------------------------------------
analyze_skills() {
    log "Analyzing skill files..."
    
    local skills_dir="$DELEGADO_ROOT/subagents"
    local report="$ANALYSIS_DIR/skills_report.md"
    
    cat > "$report" << 'HEADER'
# Skills Analysis Report

Generated: $(date)

## Coverage Analysis

| Mode | SKILL.md | Guide | Templates | Hooks | Score |
|------|----------|-------|-----------|-------|-------|
HEADER
    
    for mode_dir in "$skills_dir"/*/; do
        local mode=$(basename "$mode_dir")
        local has_skill=$([ -f "$mode_dir/SKILL.md" ] && echo "✓" || echo "✗")
        local has_guide=$(find "$mode_dir" -name "*.md" | wc -l)
        local has_templates=$([ -d "$DELEGADO_ROOT/templates/obsidian/TEMPLATE-$mode.md" ] && echo "✓" || echo "✗")
        local has_hooks=$([ -f "$DELEGADO_ROOT/scripts/hooks.d/pre_$mode.sh" ] && echo "✓" || echo "✗")
        
        # Calculate score
        local score=0
        [ "$has_skill" = "✓" ] && score=$((score + 25))
        [ "$has_guide" -gt 1 ] && score=$((score + 25))
        [ "$has_templates" = "✓" ] && score=$((score + 25))
        [ "$has_hooks" = "✓" ] && score=$((score + 25))
        
        printf "| %-12s | %-8s | %-7d | %-10s | %-6s | %-5s |\n" \
            "$mode" "$has_skill" "$has_guide" "$has_templates" "$has_hooks" "$score%" >> "$report"
    done
    
    cat >> "$report" << 'FOOTER'

## Recommendations

FOOTER
    
    log "Skills analysis complete: $report"
}

#-------------------------------------------------------------------------------
# Analyze Prompt Quality
#-------------------------------------------------------------------------------
analyze_prompts() {
    log "Analyzing prompt quality..."
    
    local meta_prompt="$DELEGADO_ROOT/META-PROMPTING.md"
    local report="$ANALYSIS_DIR/prompts_report.md"
    
    local lines=$(wc -l < "$meta_prompt")
    local words=$(wc -w < "$meta_prompt")
    local sections=$(grep -c "^## " "$meta_prompt" || echo 0)
    
    # Check for key sections
    local has_hell=$(grep -q "HELL" "$meta_prompt" && echo "✓" || echo "✗")
    local has_obsidian=$(grep -q "Obsidian" "$meta_prompt" && echo "✓" || echo "✗")
    local has_modes=$(grep -q "AGENT MODES" "$meta_prompt" && echo "✓" || echo "✗")
    local has_super=$(grep -q "SUPER-AGENT" "$meta_prompt" && echo "✓" || echo "✗")
    
    cat > "$report" << EOF
# Prompts Analysis Report

Generated: $(date)

## Meta-Prompt Statistics

| Metric | Value |
|--------|-------|
| Total Lines | $lines |
| Total Words | $words |
| Sections | $sections |
| Avg Words/Section | $((words / sections)) |

## Coverage

| Component | Present |
|-----------|---------|
| HELL Framework | $has_hell |
| Obsidian Integration | $has_obsidian |
| Agent Modes | $has_modes |
| Super-Agent System | $has_super |

## Quality Score

EOF
    
    local quality_score=0
    [ "$has_hell" = "✓" ] && quality_score=$((quality_score + 25))
    [ "$has_obsidian" = "✓" ] && quality_score=$((quality_score + 25))
    [ "$has_modes" = "✓" ] && quality_score=$((quality_score + 25))
    [ "$has_super" = "✓" ] && quality_score=$((quality_score + 25))
    
    echo "| Score | $quality_score% |" >> "$report"
    
    log "Prompts analysis complete: $report"
}

#-------------------------------------------------------------------------------
# Check Documentation Links
#-------------------------------------------------------------------------------
check_links() {
    log "Checking documentation links..."
    
    local report="$ANALYSIS_DIR/links_report.md"
    local broken=0
    
    cat > "$report" << 'HEADER'
# Documentation Links Report

Generated: $(date)

## Link Status

HEADER
    
    # Find all markdown files
    while IFS= read -r -d '' file; do
        # Extract links from markdown
        grep -oE '\[([^]]+)\]\(([^)]+)\)' "$file" 2>/dev/null | while IFS= read -r link; do
            local text=$(echo "$link" | sed 's/\[//;s/\].*//')
            local url=$(echo "$link" | sed 's/.*\](\([^)]*\)).*/\1/')
            
            # Skip internal links and anchors
            if [[ "$url" == /* ]] || [[ "$url" =~ ^# ]]; then
                continue
            fi
            
            # Check if it's a local file reference
            if [[ "$url" != http* ]]; then
                if [ ! -f "$DELEGADO_ROOT/$url" ]; then
                    echo "| $text | $url | ⚠️ MAY BE BROKEN |" >> "$report"
                    broken=$((broken + 1))
                else
                    echo "| $text | $url | ✓ |" >> "$report"
                fi
            fi
        done
    done < <(find "$DELEGADO_ROOT" -name "*.md" -print0)
    
    echo "" >> "$report"
    echo "Potentially broken links: $broken" >> "$report"
    
    log "Links check complete: $report"
}

#-------------------------------------------------------------------------------
# Generate Improvement Suggestions
#-------------------------------------------------------------------------------
suggest_improvements() {
    log "Generating improvement suggestions..."
    
    local report="$ANALYSIS_DIR/improvements.md"
    
    cat > "$report" << 'HEADER'
# Delegado OS - Improvement Suggestions

Generated: $(date)

## Priority 1: Critical

1. **Add more subagent guides** - Some modes need deeper documentation
2. **Add integration tests** - Verify hooks and mode switching work
3. **Add CI/CD pipeline** - Automated testing and quality checks

## Priority 2: Important

1. **Add example interactions** - Show real conversations in each mode
2. **Add troubleshooting section** - Common issues and solutions
3. **Add video demonstrations** - Visual walkthroughs

## Priority 3: Nice to Have

1. **Add internationalization** - Support for other languages
2. **Add more templates** - Domain-specific templates
3. **Add WebUI** - Graphical interface for mode management

## Quick Wins

1. Add `examples/` folder with sample prompts per mode
2. Add `contributing.md` guide
3. Add badges for build status
4. Add automated self-improvement cron job

---
*Report generated by auto-improve.sh*
HEADER
    
    log "Improvements suggestions complete: $report"
}

#-------------------------------------------------------------------------------
# Run All Analysis
#-------------------------------------------------------------------------------
run_full_analysis() {
    log "Starting full Delegado OS analysis..."
    
    mkdir -p "$ANALYSIS_DIR"
    
    analyze_skills
    analyze_prompts
    check_links
    suggest_improvements
    
    log "Analysis complete! Reports in: $ANALYSIS_DIR"
    echo ""
    echo "Reports generated:"
    ls -1 "$ANALYSIS_DIR"
}

#-------------------------------------------------------------------------------
# Main
#-------------------------------------------------------------------------------
case "${1:-all}" in
    all)
        run_full_analysis
        ;;
    skills)
        analyze_skills
        ;;
    prompts)
        analyze_prompts
        ;;
    links)
        check_links
        ;;
    improve)
        suggest_improvements
        ;;
    *)
        echo "Usage: $0 [all|skills|prompts|links|improve]"
        ;;
esac
