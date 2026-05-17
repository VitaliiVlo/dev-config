# CLAUDE.md

Mandatory user-level rules for Claude Code. Apply on every task. Treat every section below as required, not advisory.

Override only via project-specific instructions (`AGENTS.md`, `CLAUDE.md`, `README`), repository documentation, or a direct user request in the current conversation.

## Consistency

Match the project's existing patterns — naming, error handling, structure, formatting, commit messages, PR titles and descriptions, branch names, issue/Jira style. When unsure, copy a recent example from the same project verbatim.

- Check local guidance first: `AGENTS.md`, `CLAUDE.md`, `README`, `Makefile`, CI config, formatter/linter config, recent Git history.
- Identify the work scope before editing: single repo, or a folder grouping multiple repos for the same project.
- In a multi-repo project, check sibling repos for shared conventions — match like with like (service to service, frontend to frontend, infra to infra).
- Never introduce new conventions; reuse existing ones.
- If consistency is impossible or clearly inefficient, ask for approval before deviating.

Fallbacks only when a repo gives no signal:

- Commit messages: concise imperative sentence case — `Add ...`, `Update ...`, `Remove ...`, `Refactor ...`
- PR titles: mirror the commit style
- PR descriptions: summary, why the change exists, validation performed, notable risk

## Tools

- Prefer repo-native commands: `make`, `task`, package scripts, checked-in scripts.
- For ad-hoc shell only (search, listing, inspection): prefer `rg` over `grep`, `fd` over `find`, `bat` over `cat`, `eza` over `ls`, `jq`/`yq` for JSON/YAML parsing, `tldr` for quick command reference. Never replace a repo-defined script or `make` target with these.
- Use `gh` CLI for GitHub workflows.
- Respect `.gitignore`, lockfiles, toolchain files, and existing automation.
- Use read-only inspection first. Ask before installs, migrations, or destructive actions.
- Do not install packages or add dependencies without explicit approval. This includes `brew install`, `npm install <pkg>`, `pip install`, `uv add`, `go get`, `cargo add`. Lockfile-only refresh commands (`npm ci`, `uv sync`, `go mod tidy`) are fine.
- Avoid spawning subagents by default. Use direct tools first. Delegate only when the task clearly benefits — independent parallel work, large search surface that would pollute main context, or a specialist agent fits the job. User request always overrides.

## Git

- Rebase workflow; keep commits atomic.
- Don't amend published commits.
- Protect `main` and `master` — never force-push.
- No AI attribution in artifacts. No `Co-Authored-By` tags, no "Generated with Claude" footers, no signature lines in commits, PRs, issues, or docs. Match the repo's voice as if the user wrote them.

## Sensitive Data

Forbidden: do not search, read, edit, print, summarize, or commit secrets or private credentials.

Treat as sensitive unless explicitly approved (list is not exhaustive):

- `.env`, `.env.*`, `*.env`, `.ssh/*`, `*.pem`, `*.key`, `id_*` (e.g. `id_rsa`, `id_ed25519`)
- `.aws/credentials`, `.kube/config`, `*.kubeconfig`, `.git-credentials`, `.npmrc`, `.pypirc`, `.netrc`
- `*.tfvars`, `*.p12`, `*.pfx`, `*.jks`, `credentials.json`, `secrets.*`, private tokens, API keys, cookies, session files

If access is truly required — ask for approval first. Never echo secret values or persist them into commits, docs, tests, or logs. Never paste secret-looking strings (tokens, keys, cookies, signed URLs) into external tools, web fetches, MCP servers, or pastebins, even when the destination is a trusted vendor — once sent, they are out of your control.

## Change Execution

- Read before editing. Change the smallest sensible surface area.
- Keep related docs, tests, and config in sync when code changes make that necessary.
- Do not add abstractions or boilerplate unless the repository already uses them.
- Ask first when: secrets access is required, the action is destructive, convention is unclear with team-facing impact, or an architectural decision is at stake.
- Do not hand-edit generated files (`*.pb.go`, `openapi.gen.ts`, `mock_*.go`, vendored deps, lockfiles produced by tooling, etc.). Regenerate via the documented command and commit the result.

## Comments

Do not add comments by default. Names, types, and signatures already explain *what* the code does; restating that adds noise and rots fast.

A comment is permitted only when *why* is non-obvious, or *what* is genuinely hard to follow even after careful reading — a hidden constraint, subtle invariant, workaround for an upstream bug, surprising ordering, behavior that contradicts the obvious read of the code, or a complex algorithm or piece of logic where naming and structure alone cannot carry the meaning. If removing the comment would confuse a careful reader, write it; otherwise do not. Keep it clear, focused, and short where possible; match the surrounding style.

Never:

- Comment every function, class, or block as a habit.
- Reference the current task, ticket, PR, fix, or call sites (`// added for AUTH-123`, `// used by X`, `// fix from review`). That belongs in commit messages and PR descriptions; in code it rots fast.
- Teach standard language or framework idioms.
- Leave new `TODO` / `FIXME` markers without an owner or ticket reference.

When editing nearby code, delete comments that have become wrong, redundant, or pure restatement.

## Recommendations

When presenting options, alternatives, fixes, or approaches, mark one as recommended with a short reason. Add detail on weaker alternatives only when it helps the decision. The user may override based on context you lack — never present a menu without a recommendation.

## Iterative Review

When the user asks to iterate over findings, issues, or any list of items:

- One item per turn. Explain the item in enough depth that the user can decide without follow-up: what it is, why it matters, what changes if applied, what stays if skipped.
- Present the proposed fix in full, plus alternative options when meaningful. For each option, explain what it does and its trade-off (effect, behavior change, risk, scope). Mark one as recommended with a reason proportionate to the decision — one line for trivial choices, more when the trade-off is real.
- Wait for an explicit decision (approve, skip, pick an option) before doing anything.
- After the decision, apply the change immediately and verify it. Only move to the next item once the current one is fully resolved (applied or skipped).
- Show a running tracker each turn (`✅ applied`, `⏭ skipped`, `🟡 pending`).

## Scratch Files

Use `/tmp/claude` for all temporary internal artifacts: scratch outputs, notes, drafts, intermediate files, throwaway scripts. Never write ephemera to `/tmp` root or the working directory. Create the directory on demand if missing (`mkdir -p /tmp/claude`). Clean up your own files when the task is done.
