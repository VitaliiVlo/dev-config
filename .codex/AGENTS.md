# AGENTS.md

Core user-level instructions for Codex and similar coding agents. Repository-level instructions and direct user requests take precedence.

## Consistency

Be extremely consistent with the current project's existing patterns:

- **Code** — match naming, error handling, structure, formatting of surrounding code.
- **Commits** — follow the repo's existing commit message style and format.
- **PRs** — match the team's PR title and description conventions.
- **Branches** — follow the repo's branch naming pattern.
- **Issues / Jira** — match existing task title and description style in the project.
- **Everything else** — when unsure, look at recent examples in the project and follow them exactly.

Never introduce new conventions. Always check existing patterns first.
Identify the work scope: a single repo or a folder grouping multiple repos for the same project.
In a multi-repo project, check sibling repos for shared conventions — match like with like (service to service, frontend to frontend, infra to infra).
If consistency is impossible or clearly inefficient, ask for approval before deviating.
Start by checking local guidance: `AGENTS.md`, `CLAUDE.md`, `README`, `Makefile`, CI, formatter/linter config, and recent Git history.

Fallbacks only when a repo gives no signal:

- Commit messages: concise imperative sentence case — `Add ...`, `Update ...`, `Remove ...`, `Refactor ...`
- PR titles: mirror the commit style
- PR descriptions: summary, why the change exists, validation performed, and any notable risk

## Tools

- Prefer repo-native commands first: `make`, `task`, package scripts, checked-in scripts.
- Prefer modern CLI equivalents: `rg` over `grep`, `fd` over `find`, `bat` over `cat`, `eza` over `ls`.
- Use `gh` CLI for GitHub workflows.
- Respect `.gitignore`, lockfiles, toolchain files, and existing automation.
- Use read-only inspection first. Ask before installs, migrations, or destructive actions.

## Git

- Rebase workflow; keep commits atomic.
- Don't amend published commits.
- Protect `main` and `master` — never force-push.

## Sensitive Data

Forbidden by default — do not search, read, edit, print, summarize, or commit secrets or private credentials.

Treat at least the following as sensitive unless the user explicitly approves access:

- `.env`, `.env.*`, `*.env`, `.ssh/*`, `*.pem`, `*.key`, `*_rsa`, `*_ed25519`
- `.aws/credentials`, `.kube/config`, `.git-credentials`, `.npmrc`, `.pypirc`, `.netrc`
- `*.tfvars`, `credentials.json`, `secrets.*`, private tokens, API keys, cookies, session files

If access is truly required — ask for approval first. Never echo secret values or persist them into commits, docs, tests, or logs.

## Change Execution

- Read before editing. Change the smallest sensible surface area.
- Keep related docs, tests, and config in sync when code changes make that necessary.
- Do not add abstractions or boilerplate unless the repository already uses them.
- Ask before proceeding when: secrets access is required, a destructive action is needed, convention is unclear with team-facing impact, or an architectural decision is needed.
