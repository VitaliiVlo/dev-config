# Iterate Findings

Step through findings one at a time with detailed explanations and explicit user approval.

## Arguments

- `$ARGUMENTS` - Optional: category, severity filter, or path

## Supported Sources

Works with any prior command that produces iterable findings:

| Source | Produces |
|--------|----------|
| `/audit` | Findings with severity, category, location |
| `/diff-audit` | Findings with severity, location |
| Any command | Actionable suggestions with location |

## Filters

| Argument | Behavior |
|----------|----------|
| (none) | All findings from prior command |
| `security`, `performance`, `quality`, `architecture`, `tests`, `dependencies`, `docs` | Filter by category |
| `critical`, `high`, `medium`, `low` | Filter by minimum severity |
| `./path` | Filter by file or directory |
| Combined filters | Space-separated, order doesn't matter |

**Note:** Category filters only work when the source command categorizes findings (e.g., `/audit`). Severity and path filters work with all sources. Irrelevant filters are silently ignored.

## Prerequisites

- Prior command with iterable findings in conversation history
- If no prior findings, reports error and suggests commands to run

## Examples

```
/iterate                # All findings from prior command
/iterate security       # Security findings only
/iterate high           # High and Critical only
/iterate ./src          # Findings in ./src directory
/iterate security high  # Security at High+ severity
```

## Process

1. **Determine scope**
   - Check conversation history for findings from prior command
   - Findings exist only in conversation memory (not persisted to disk)
   - If no prior findings, report error: "No findings to iterate. Run `/audit` or `/diff-audit` first."
   - Apply filters from `$ARGUMENTS` if specified
   - Report: "Iterating N findings from `/audit`" (or whichever source)

2. **Present each finding**

   ```
   ## Finding [N] of [Total]: [Title]

   **Severity:** Critical / High / Medium / Low
   **Location:** `file:line`
   **Problem:** What's wrong
   **Impact:** Why it matters
   **Fix:** Proposed change (show diff)
   ```

3. **Get explicit approval** - use AskUserQuestion with these options:
   - "Apply" - Make this change
   - "Skip" - Move to next finding
   - "Stop" - End iteration

4. **After completion** - summarize:
   - Applied: N changes
   - Skipped: N findings
   - Remaining: N findings (if stopped early)

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

## Severity Levels

| Level | Description |
|-------|-------------|
| **Critical** | Security vulnerabilities, data loss risks, crashes |
| **High** | Bugs, significant issues, breaking changes |
| **Medium** | Code quality, maintainability, minor bugs |
| **Low** | Style, minor improvements, suggestions |

## Workflow Integration

Designed to follow any command that produces findings:

```
/audit              → /iterate           # Fix all audit findings
/audit security     → /iterate           # Fix security findings
/diff-audit         → /iterate           # Fix issues in changes
/diff-audit staged  → /iterate critical  # Fix only critical issues
```

## Edge Cases

| Scenario | Behavior |
|----------|----------|
| No prior findings | Report error: "No findings to iterate. Run `/audit` or `/diff-audit` first." |
| No findings match filter | Report "No findings match filter [X]" and exit |
| Fix fails to apply (file changed) | Report conflict, show current state, ask how to proceed |
| User wants to undo | Note that changes can be reverted with git; suggest `git diff` to review |
| All findings addressed | Report completion and suggest running tests |
| Session cleared after prior command | Report "Prior findings not available. Run source command again." |
| Fix introduces new issues | Pause iteration, report new issue, ask how to proceed |
| Finding already fixed | Detect resolved state, report "Already fixed", move to next |
| Invalid filter argument | Suggest closest match or list valid filters |
| `/iterate` called mid-iteration | Ask via AskUserQuestion: "Resume from finding N?" or "Restart?" |
| Multiple source commands in history | Use most recent findings; note which command |

## Rules

- Always state the source of findings before iterating (prior command name)
- One finding at a time, never batch
- Always use AskUserQuestion for approval prompts (Apply/Skip/Stop)
- Never apply without explicit approval via AskUserQuestion
- Be honest about trade-offs and risks
- Stop immediately when user selects Stop
- Show progress: "Finding 3 of 12"
- If a fix causes new issues, pause and report

**Do NOT:**
- Batch multiple fixes without individual approval
- Modify files not mentioned in the current finding
- Apply fixes that change behavior beyond the issue scope
- Skip showing the diff before applying
- Use text-based approval prompts; always use AskUserQuestion

## See Also

- `/audit` - Full codebase audit
- `/diff-audit` - Audit changed code only
- `/commit` - Commit changes after fixing
