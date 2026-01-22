# Update README

Analyze this repository and update README.md to accurately reflect its current state.

## Arguments

- `$ARGUMENTS` - Optional: sections to focus on (e.g., "installation", "usage", "api", "configuration")

## Prerequisites

- None (works in any directory)

## Examples

```
/readme                 # Analyze and update entire README
/readme installation    # Focus on installation section only
/readme usage api       # Update usage and API sections
```

## Process

1. **Explore the repository** - structure, configs, scripts, dependencies
2. **Read existing docs** - README.md, CLAUDE.md, any other documentation
3. **Identify gaps** - missing info, outdated content, inaccuracies
4. **Propose changes** - show what will change and why:
   - Brief summary of repository contents
   - List of proposed changes with rationale
   - Show the diff or new content for review
5. **Get approval** - use AskUserQuestion with options:
   - "Apply all" - Make all proposed changes at once
   - "Apply partial" - Choose which specific changes to apply
   - "Modify" - Adjust proposal before applying (user provides feedback via "Other")
   - "Cancel" - Make no changes to README
6. **Apply after approval** - make approved changes

## Edge Cases

| Scenario | Behavior |
|----------|----------|
| No README exists | Create with: Title, Description, Installation, Usage, Configuration, License |
| README is outdated | Highlight specific outdated sections, propose updates |
| Partial update requested | If `$ARGUMENTS` specifies sections, focus only on those |
| README is accurate | Report "No changes needed" and exit |
| Custom sections exist | Preserve user's custom sections; only modify relevant parts |
| Badges/shields present | Preserve existing badges; don't add new ones unless requested |
| Non-English README | Preserve language; don't translate unless requested |
| Multiple READMEs | Update root README by default; ask if others should be updated |
| README conflicts with CLAUDE.md | Note discrepancy, propose reconciliation |
| File is read-only | Report permission error, suggest checking file permissions |
| Invalid section argument | Suggest closest match or list common sections |

## Rules

- Preserve user's existing structure and writing style
- Always use AskUserQuestion for approval prompts
- Never remove sections without explicit approval via AskUserQuestion
- If no changes needed, report that clearly
- Keep README focused - avoid unnecessary boilerplate
- Match the tone and formatting of existing content

**Do NOT:**
- Add generic boilerplate (contributing guidelines, code of conduct) unless requested
- Remove or modify badges without asking
- Add emojis unless the existing README uses them
- Change the language of the README
- Use text-based approval prompts; always use AskUserQuestion

## See Also

- `/audit docs` - Audit documentation across the codebase
