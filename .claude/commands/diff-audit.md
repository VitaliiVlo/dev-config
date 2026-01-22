# Diff Audit

Review changes for bugs, security issues, and inconsistencies.

## Arguments

- `$ARGUMENTS` - Optional: what to compare (see modes below)

## Modes

| Argument | What it compares | Git command |
|----------|------------------|-------------|
| (none) | Ask user what to compare | — |
| `staged` | Staged changes vs HEAD | `git diff --cached` |
| `modified` | Staged + unstaged changes vs HEAD | `git diff HEAD` |
| `main` | Current branch vs base branch (commits only) | `git diff main...HEAD` |
| `main+local` | Current branch + uncommitted vs base branch | `git diff main` |
| `#123` or PR URL | Pull request changes | `gh pr diff 123` |

**Note:** Replace `main` with your default branch (`master`, `develop`, etc.) as needed.

## Prerequisites

- Git repository required
- `gh` CLI required for PR mode (`#123` or GitHub PR URL)

## Examples

```
/diff-audit             # Ask user what to compare
/diff-audit staged      # Review only staged changes
/diff-audit modified    # Review all uncommitted changes
/diff-audit main        # Compare to main (commits only)
/diff-audit main+local  # Compare to main (commits + uncommitted)
/diff-audit #456        # Review PR #456 (requires gh CLI)
```

## Process

1. **Determine diff scope** - from `$ARGUMENTS` or ask user:
   - If no arguments provided, first run `git diff --stat` for each mode to get counts
   - Use AskUserQuestion with options (include file/line counts):
     - "Staged (N files, +X/-Y)" - staged changes only
     - "Modified (N files, +X/-Y)" - all local changes vs HEAD
     - "vs base branch" - compare to main/master (user specifies branch via Other)
   - If argument provided, use that target directly
2. **Retrieve changes** - get diff using appropriate git command
3. **Analyze each change** - check against review checklist below
4. **Report findings** - grouped by severity

## Review Checklist

| Category | What to look for |
|----------|------------------|
| **Bugs** | Logic errors, null handling, race conditions, resource leaks |
| **Security** | Secrets, injection, XSS, insecure patterns |
| **Quality** | Naming, duplication, dead code, complexity |
| **Consistency** | Style, API compatibility, missing tests/docs |
| **Performance** | N+1 queries, inefficient algorithms, missing caching |

## Severity Levels

| Level | Description |
|-------|-------------|
| **Critical** | Security vulnerabilities, data loss risks, crashes |
| **High** | Bugs, significant issues, breaking changes |
| **Medium** | Code quality, maintainability, minor bugs |
| **Low** | Style, minor improvements, suggestions |

## Report Format

```
## Diff Audit Report

**Comparing:** [source] → [target]
**Files changed:** N
**Lines:** +N / -N

### Critical (N)
[Issues that must be fixed]

### High (N)
[Issues that should be fixed]

### Medium (N)
[Issues worth considering]

### Low (N)
[Minor suggestions]

### Summary
[Overall assessment: Ready / Needs attention / Significant concerns]

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
| Empty diff | Report "No changes to audit" and exit |
| Binary files | Note their presence, skip content analysis |
| Merge conflicts | Report as Critical - must be resolved first |
| PR mode without `gh` | Fall back to branch comparison if possible, otherwise report error |
| Large diff (>50 files) | Summarize by directory, focus on high-risk changes |
| File renames | Track renames (`git diff -M`), compare content not just paths |
| Submodule changes | Note submodule pointer changes, don't recurse into submodule |
| Generated file changes | Note but deprioritize; focus on source that generated them |
| Not a git repository | Report error: "Requires git repository. Use /audit for non-git projects." |
| No remote configured | Note limited context; PR mode may fail |
| Invalid mode argument | Suggest closest match or list valid modes |
| Branch/commit not found | Report error with suggestion: "Branch 'mian' not found. Did you mean 'main'?" |
| Stash exists | Note stashed changes; not included in diff |
| Dirty working directory with PR mode | Warn about local changes not in PR |
| Interrupted mid-process | Provide partial report; note to re-run for complete audit |

## Rules

- Be thorough but avoid false positives
- Always use AskUserQuestion when no argument provided - never guess what to compare
- Consider intent and context of changes
- Prioritize actionable feedback
- Clearly distinguish must-fix from nice-to-have
- Focus on the changes, not pre-existing issues

**Do NOT:**
- Report pre-existing issues unrelated to the changes
- Flag formatting if project uses auto-formatter
- Nitpick style choices that are consistent with codebase
- Suggest refactoring beyond the scope of the change

## See Also

- `/iterate` - Step through and fix findings one by one
- `/iterate critical` - Address only critical issues first
- `/audit` - Full codebase audit (not just changes)
- `/commit` - Commit changes after review
