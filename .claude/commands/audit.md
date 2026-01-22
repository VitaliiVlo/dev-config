# Project Audit

Analyze the entire codebase for improvements, issues, and technical debt.

## Arguments

- `$ARGUMENTS` - Optional: category or path (see below)

## Categories

| Argument | Focus |
|----------|-------|
| (none) | Full audit across all categories (no arguments) |
| `security` | Vulnerabilities, secrets, insecure patterns |
| `performance` | Bottlenecks, inefficient code, optimization opportunities |
| `quality` | Code smells, complexity, duplication, naming |
| `consistency` | Naming conventions, error handling patterns, API style, code organization |
| `architecture` | Structure, patterns, coupling, separation of concerns |
| `tests` | Coverage gaps, test quality, missing edge cases |
| `dependencies` | Outdated, vulnerable, unused, or redundant deps |
| `docs` | Missing or outdated documentation |
| `./path` | Audit specific file or directory |

**Note:** Use `./` prefix for paths to distinguish from category names (e.g., `./docs` for a directory vs `docs` for documentation category).

**Combining filters:** Category and path can be combined (e.g., `/audit security ./pkg`).

## Prerequisites

- None (works in any directory with source code)

## Examples

```
/audit                  # Full audit across all categories
/audit security         # Security-focused audit only
/audit ./pkg/auth       # Audit specific directory
/audit ./main.go        # Audit single file
/audit security ./pkg   # Security audit of specific directory
```

## Process

1. **Scope the audit**
   - Determine focus from `$ARGUMENTS`
   - Identify relevant files and patterns to analyze
   - For monorepos or large codebases, use AskUserQuestion with options (include file counts):
     - "Entire repository (N files)" - audit everything
     - "Root-level only (N files)" - skip nested projects
     - "Specific project" - enter project path via Other

2. **Analyze codebase**
   - Explore project structure and architecture
   - Read key files and identify patterns
   - Check for issues in the focused category (or all)

3. **Report findings** grouped by severity

## Severity Levels

| Level | Description |
|-------|-------------|
| **Critical** | Security vulnerabilities, data loss risks, crashes |
| **High** | Bugs, significant issues, breaking changes |
| **Medium** | Code quality, maintainability, minor bugs |
| **Low** | Style, minor improvements, suggestions |

## Report Format

```
## Project Audit Report

**Scope:** [Full / Category / Path]
**Files analyzed:** N
**Issues found:** N (X critical, Y high, Z medium, W low)

### Critical (N)
[List with file:line, description, recommendation]

### High (N)
...

### Medium (N)
...

### Low (N)
...

### Summary
[Overall health assessment and top priorities]

---
Run `/iterate` to address findings one by one.
```

## Issue Format

Each issue includes:
- **[SEVERITY]** `file:line` - Brief description
- **Problem:** What's wrong
- **Impact:** Why it matters
- **Fix:** How to resolve it

## Edge Cases

| Scenario | Behavior |
|----------|----------|
| Empty or minimal codebase | Report "No significant issues" with brief summary |
| Monorepo with multiple projects | Ask which project to audit, or audit root-level only |
| Config-only repo (no source code) | Focus on config validation, skip code-specific checks |
| Audit interrupted | Provide partial report with note to re-run for complete results |
| Non-git repository | Continue without git history analysis; note limited context |
| Vendor/generated code | Skip `vendor/`, `node_modules/`, `*.pb.go`, `*_generated.go` by default |
| Very large codebase | Sample representative files; prioritize high-risk areas |
| Argument matches category and directory | Treat as category; user must use `./` prefix for path |
| Invalid category argument | Suggest closest match or list valid categories |

## Rules

- Prioritize actionable findings over theoretical concerns
- Consider project context (size, maturity, purpose)
- Avoid false positives - only report real issues
- Group related issues to avoid repetition
- Be specific about locations and fixes
- Limit to ~20 findings per severity; note if more exist
- Report "No issues found" if codebase is clean

**Do NOT:**
- Flag issues in generated code (`node_modules/`, `vendor/`, `*.pb.go`)
- Report style issues handled by formatters (`gofmt`, `prettier`, `black`)
- Flag test code for production-level error handling
- Report theoretical issues without concrete evidence

## See Also

- `/iterate` - Step through findings with approval
- `/iterate security` - Address only security issues
- `/iterate high` - Address only high+ severity
- `/diff-audit` - Audit only changed code
