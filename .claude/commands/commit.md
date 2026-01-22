# Commit Changes

Analyze changes and create a commit with a descriptive message.

## Arguments

- `$ARGUMENTS` - Optional: what to commit (see modes below)

## Modes

| Argument | What it commits |
|----------|-----------------|
| (none) | Ask user what to commit |
| `all` | Everything: staged + unstaged + untracked |
| `staged` | Only staged changes |
| `modified` | Modified/deleted files only (no untracked) |
| `<file>` | Specific file or pattern |

## Prerequisites

- Git repository required

## Examples

```
/commit                 # Ask user what to commit
/commit all             # Commit everything (staged + unstaged + untracked)
/commit staged          # Commit only staged changes
/commit modified        # Commit modified/deleted files, skip untracked
/commit ./src           # Commit changes in ./src directory
/commit *.md            # Commit all markdown files
```

## Process

1. **Determine scope** - from `$ARGUMENTS` or ask user using AskUserQuestion:
   - If no arguments provided, use AskUserQuestion with options:
     - "All changes" - staged + unstaged + untracked
     - "Staged only" - only staged changes
     - "Modified only" - skip untracked files
   - If argument provided, use that mode directly
2. **Analyze changes** - read diffs to understand what changed
3. **Check commit history** - match repository's commit message style
4. **Generate message** - create concise, descriptive commit message
5. **Show preview** - display what will be committed and the message
6. **Get approval** - use AskUserQuestion with options:
   - "Commit" - proceed with the commit
   - "Edit message" - user provides new message via "Other", then show preview again
   - "Cancel" - abort without committing

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

**Mode:** [all / staged / modified / path]
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
| Stash exists | Note stashed changes exist; don't auto-apply |
| Submodule changes | Note submodule pointer change; don't commit submodule contents |

## Rules

- Always show preview before committing
- Use AskUserQuestion for mode selection (when no args) and approval prompts
- Never commit without explicit approval via AskUserQuestion
- Keep messages concise (under 72 chars for subject)
- Use imperative mood ("Add" not "Added")
- Reference files/components changed
- Match existing commit message style in repo

**Do NOT:**
- Commit without showing what will be committed
- Include sensitive files (`.env`, credentials, keys)
- Create empty commits
- Use generic messages like "Update files" or "Fix stuff"
- Do not add Co-Authored-By trailer (keep commit history clean)
- Use text-based approval prompts; always use AskUserQuestion

## See Also

- `/diff-audit` - Review changes before committing
- `/diff-audit staged` - Audit only staged changes
- `/iterate` - Fix issues before committing
