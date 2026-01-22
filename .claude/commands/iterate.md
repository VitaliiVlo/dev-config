# Iterate Through Findings

Step through findings one at a time with detailed explanations and explicit user approval.

## Arguments

- `$ARGUMENTS` - Optional: category, severity filter, or path

## Filters

| Argument | Behavior |
|----------|----------|
| (none) | All findings from prior audit, or fresh analysis |
| `security`, `performance`, `quality`, `architecture`, `tests`, `dependencies`, `docs` | Filter by category |
| `critical`, `high`, `medium`, `low` | Filter by minimum severity |
| `./path` | Filter by file or directory |
| Combined filters | Space-separated, order doesn't matter |

## Severity Levels

| Level | Description |
|-------|-------------|
| **Critical** | Security vulnerabilities, data loss risks, crashes |
| **High** | Bugs, significant issues, breaking changes |
| **Medium** | Code quality, maintainability, minor bugs |
| **Low** | Style, minor improvements, suggestions |

## Examples

```
/iterate                # All findings from prior audit
/iterate security       # Security findings only
/iterate high           # High and Critical only
/iterate ./src          # Findings in ./src directory
/iterate security high  # Security at High+ severity
```

## Filter Details

| Input | Result |
|-------|--------|
| `security` | All security findings |
| `high` | High and Critical severity only |
| `security high` | Security findings at High+ severity |
| `high security` | Same as above (order doesn't matter) |
| `./src` | All findings in `./src` directory |
| `./src high` | High+ findings in `./src` |
| `./pkg/auth security` | Security findings in auth package |

## Workflow Integration

Designed to follow `/audit` or `/diff-audit`:

```
/audit              → /iterate           # Fix all audit findings
/audit security     → /iterate           # Fix security findings
/diff-audit         → /iterate           # Fix issues in changes
/diff-audit staged  → /iterate critical  # Fix only critical issues
```

## Process

1. **Determine scope**
   - Check conversation history for findings from prior `/audit` or `/diff-audit`
   - Findings exist only in conversation memory (not persisted to disk)
   - If no prior findings exist, perform fresh analysis
   - Apply filters from `$ARGUMENTS` if specified

2. **Present each finding**

   ```
   ## Finding [N] of [Total]: [Title]

   **Severity:** Critical / High / Medium / Low
   **Location:** `file:line`
   **Problem:** What's wrong
   **Impact:** Why it matters
   **Fix:** Proposed change (show diff)
   ```

3. **Get explicit approval** - offer these choices:
   - **Apply** - Make this change
   - **Modify** - Adjust the fix before applying
   - **Skip** - Move to next finding
   - **List** - Show all remaining findings
   - **Stop** - End iteration

4. **After completion** - summarize:
   - Applied: N changes
   - Skipped: N findings
   - Remaining: N findings (if stopped early)

## Edge Cases

| Scenario | Behavior |
|----------|----------|
| No prior findings, no arguments | Perform fresh full audit, then iterate |
| No findings match filter | Report "No matching findings" and exit |
| Fix fails to apply (file changed) | Report conflict, show current state, ask how to proceed |
| User wants to undo | Note that changes can be reverted with git; suggest `git diff` to review |
| All findings addressed | Report completion and suggest running tests |
| Session cleared after audit | Perform fresh analysis; prior findings not available |
| Fix introduces new issues | Pause iteration, report new issue, ask how to proceed |
| Finding already fixed | Detect resolved state, report "Already fixed", move to next |
| Invalid filter argument | Suggest closest match or list valid filters |

## Rules

- One finding at a time, never batch
- Never apply without explicit approval
- Be honest about trade-offs and risks
- Stop immediately when user says stop
- Show progress: "Finding 3 of 12"
- If a fix causes new issues, pause and report

**Do NOT:**
- Batch multiple fixes without individual approval
- Modify files not mentioned in the current finding
- Apply fixes that change behavior beyond the issue scope
- Skip showing the diff before applying

## See Also

- `/audit` - Full codebase audit
- `/diff-audit` - Audit changed code only
- `/commit` - Commit changes after fixing
