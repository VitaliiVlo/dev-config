# Commit Changes

Analyze changes and create a commit with a descriptive message.

## Arguments

- `$ARGUMENTS` - Optional: what to commit (see modes below)

## Modes

| Argument | What it commits |
|----------|-----------------|
| (none) | All changes (staged + unstaged + untracked) |
| `staged` | Only staged changes |
| `tracked` | All tracked changes (no untracked files) |
| `<file>` | Specific file or pattern |

## Prerequisites

- Git repository required

## Examples

```
/commit                 # Commit everything (default)
/commit staged          # Commit only staged changes
/commit tracked         # Commit tracked changes, skip untracked files
/commit ./src           # Commit changes in ./src directory
/commit *.md            # Commit all markdown files
```

## Process

1. **Determine scope** - from `$ARGUMENTS` or default to all
2. **Analyze changes** - read diffs to understand what changed
3. **Check commit history** - match repository's commit message style
4. **Generate message** - create concise, descriptive commit message
5. **Show preview** - display what will be committed and the message
6. **Commit after approval** - wait for user confirmation

## Commit Message Format

Follow this repository's style:
- Format: `[Action] [scope]: [details]`
- Action: Add, Update, Remove, Fix, Refactor
- Scope: file name, component, or "configuration files" for multiple
- Details: brief description of what changed

Examples from this repo:
```
Update configuration files: enhance VSCode settings and add default settings reference
Add bat configuration file and update bootstrap script for symlink
Fix bootstrap.sh: correct symlink path for ghostty config
```

## Preview Format

```
## Commit Preview

**Mode:** [all / staged / tracked / path]
**Files:** N files changed

### Changes
[List of files with +/- summary]

### Proposed Message
[Generated commit message]

---
[Approval prompt]
```

## Edge Cases

| Scenario | Behavior |
|----------|----------|
| No changes | Report "Nothing to commit" and exit |
| Staged mode with nothing staged | Report "No staged changes" and exit |
| Untracked files only | Ask whether to include them |
| Binary files | Note their presence in commit |
| Large number of files (>20) | Summarize by directory |
| Merge in progress | Report error: "Resolve merge first" |
| Detached HEAD | Warn user, ask for confirmation |
| Protected files in changes | Warn about `.env`, credentials, etc. |
| Commit hook fails | Report error, suggest fix |
| Invalid path argument | Report "Path not found" with suggestions |
| Rebase in progress | Report error: "Complete or abort rebase first" |
| Cherry-pick in progress | Report error: "Complete or abort cherry-pick first" |
| Shallow clone | Warn about limited history context for message style |

## Rules

- Always show preview before committing
- Never commit without explicit approval
- Keep messages concise (under 72 chars for subject)
- Use imperative mood ("Add" not "Added")
- Reference files/components changed
- Match existing commit message style in repo

**Do NOT:**
- Commit without showing what will be committed
- Include sensitive files (`.env`, credentials, keys)
- Create empty commits
- Use generic messages like "Update files" or "Fix stuff"
- Add Co-Authored-By unless user requests it

## See Also

- `/diff-audit` - Review changes before committing
- `/diff-audit staged` - Audit only staged changes
- `/iterate` - Fix issues before committing
