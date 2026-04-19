# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

macOS dotfiles repository for setting up a development environment. All configs use **Catppuccin Macchiato** (dark) / **Catppuccin Latte** (light) theme where supported, **JetBrains Mono** font (14pt) with **Fira Code**, **Menlo**, **Monaco**, and **Symbols Nerd Font Mono** fallbacks. Configured for **Go 1.26** (via Homebrew), **Python** (via `uv`), and **Node.js** (via `fnm`).

## Key Commands

```bash
just install           # Full setup: symlink configs and install packages
just link              # Symlink configs to home directory
just defaults          # Configure macOS defaults (interactive): folders, Finder, Dock, screenshots, system
just versions          # Show installed Go, Node, Python versions
just brew-install       # Install all packages (core + extra)
just brew-install-core  # Install core packages only
just brew-install-extra # Install extra packages only
just brew-check        # Check for missing Brewfile packages
just brew-outdated     # Show outdated Homebrew packages
just brew-update       # Update and upgrade all Homebrew packages
just brew-cleanup      # Clean up old versions and cache
just brew-export       # Export installed packages (incl. VSCode extensions) to .Brewfile.core; keep .Brewfile.extra curated manually
```

## Repository Structure

- `bootstrap.sh` - Creates symlinks (uses `set -euo pipefail`)
- `bootstrap-defaults.sh` - macOS defaults via `defaults write` (interactive prompts)
- `justfile` - Task runner recipes (`just` for list)
- `.Brewfile.core` - Core packages: shell essentials, fonts, daily-driver apps, VSCode extensions
- `.Brewfile.extra` - Extra packages: work-specific tooling, IDEs, infra (curated manually)
- `.zshrc` / `.zprofile` - Zsh config (starship prompt, fnm, uv, fzf with bat preview, eza aliases, syntax-highlighting, autosuggestions)
- `.gitconfig` / `.gitignore_global` - Git settings (delta pager, rebase workflow, SSH for GitHub, zdiff3 conflicts, rerere)
- `.ripgreprc` - Ripgrep defaults (smart-case, hidden files, follow symlinks)
- `.config/ghostty/config` - Terminal emulator
- `.config/starship.toml` - Shell prompt (nerd-font-symbols preset)
- `.config/bat/config` - Cat replacement with syntax highlighting
- `.config/btop/btop.conf` - System monitor (tokyo-night theme, closest to Catppuccin)
- `.config/gh/config.yml` - GitHub CLI settings (SSH protocol, delta pager)
- `.config/lazygit/config.yml` - Git TUI (nerd fonts, delta pager, vscode editor)
- `.config/micro/settings.json` - Terminal text editor
- `.config/yazi/yazi.toml` - Terminal file manager settings
- `.config/Code/User/settings.json` - VSCode settings (JSONC format with comments)
- `.config/Code/User/defaultSettings.jsonc` - VSCode defaults reference (for comparing settings)
- `.config/zed/settings.json` - Zed editor (Catppuccin Macchiato/Latte, JetBrains Mono, same UX as VSCode, auto_install_extensions)
- `.claude/CLAUDE.md` - Claude Code user-level instructions (symlinked to `~/`)
- `.claude/settings.json` - Claude Code permissions (web, git, docker, build tools, sensitive file protection)
- `.config/ccstatusline/settings.json` - Claude Code status line layout (via ccstatusline)
- `.codex/AGENTS.md` - Codex user-level instructions (symlinked to `~/`)
- `.codex/config.toml` - Codex CLI config (model, sandbox, profiles, plugins)
- `.codex/rules/` - Codex permission rules: `git`, `dev`, `shell`, `infra` (symlinked to `~/`)

## Script Behavior

**bootstrap.sh:**

- Uses `ln -sf` (force symlink) - overwrites existing files
- Creates parent directories as needed for nested configs
- macOS-specific: VSCode path is `~/Library/Application Support/Code/User/`

**bootstrap-defaults.sh:**

- Interactive: prompts for each category (Projects folder, Screenshots, Finder, Dock, System defaults)
- Restarts affected processes (Finder, Dock, SystemUIServer)
- Safe to re-run: idempotent `mkdir -p` and `defaults write` commands

## Shell Aliases

Defined in `.zshrc`:

| Alias    | Command                                |
| -------- | -------------------------------------- |
| `python` | `python3`                              |
| `pip`    | `pip3`                                 |
| `tf`     | `terraform`                            |
| `kk`     | `kubectl`                              |
| `kctx`   | `kubectl config current-context`       |
| `lzg`    | `lazygit`                              |
| `c`      | `clear`                                |
| `cat`    | `bat` (if installed)                   |
| `ls`     | `eza --icons=auto --group-directories-first`        |
| `ll`     | `eza` with git, timestamps, headers    |
| `lt`     | `eza` tree view (2 levels)             |
| `lr`     | `eza` sorted by modified (recent last) |

## Shell Tool Integration

fd and ripgrep share consistent defaults for daily use:

| Behavior        | fd                                                       | ripgrep        |
| --------------- | -------------------------------------------------------- | -------------- |
| Hidden files    | `--hidden`                                               | `--hidden`     |
| Follow symlinks | `--follow`                                               | `--follow`     |
| Exclusions      | `.git`, `node_modules`, `.venv`, `venv`, `__pycache__`, `.pytest_cache`, `.terraform`, `vendor`, `dist`, `build`, `coverage` | Same |
| Config location | Alias in `.zshrc` (no config file support)               | `~/.ripgreprc` |

fzf uses fd when available for faster fuzzy finding with bat preview:

- `Ctrl+T` - File search with bat preview
- `Ctrl+R` - History search (no preview)
- `Alt+C` - Directory search with eza tree preview

zoxide provides smart directory jumping via `z` command (learns from `cd` usage).

fnm (Fast Node Manager) auto-switches Node versions via `.node-version` or `.nvmrc` when entering a directory (`--use-on-cd`).

uv manages Python versions and project dependencies. System `python3` comes from Xcode CLT or brew; `uv` handles per-project venvs and global CLI tools (`uv tool install`). Shell completions are loaded in `.zshrc`.

git-delta is configured as the git pager (`.gitconfig`) with Catppuccin Macchiato syntax theme. It uses bat's theme engine — the theme is available because bat has it installed.

## Git Aliases

Defined in `.gitconfig`:

| Alias  | Command                            |
| ------ | ---------------------------------- |
| `st`   | `status`                           |
| `df`   | `diff`                             |
| `dfs`  | `diff --staged`                    |
| `dfw`  | `diff --word-diff`                 |
| `dfws` | `diff --staged --word-diff`        |
| `cm`   | `commit -m`                        |
| `ca`   | `commit --amend --no-edit`         |
| `lg`   | `log --oneline --graph --decorate` |
| `undo` | `reset --soft HEAD~1`              |
| `wipe` | `reset --hard HEAD`                |

## Config Validation

```bash
ghostty +show-config --default --docs      # Should show parsed config, no errors
bat --list-themes | grep -i catppuccin     # Should show "Catppuccin Macchiato"
delta --list-syntax-themes | grep -i catppuccin  # Should show Catppuccin themes
btop --version                              # Should show version (config loads on start)
starship config                             # Should show TOML config
git config --list --show-origin             # Should show ~/.gitconfig as source
fnm list                                    # Should show installed Node versions
uv python list --only-installed             # Should show installed Python versions
```

## VSCode Settings

When modifying `.config/Code/User/settings.json`:

- Compare against `defaultSettings.jsonc` to check if a setting matches the default (redundant)
- Settings use JSONC format (JSON with comments and trailing commas allowed)
- Configured for Go, Python, and Node.js backend development
- Uses Ruff for Python formatting/linting

**Layout (settings.json):**

- `window.commandCenter`: false (no project name in title bar)
- `workbench.navigationControl.enabled`: false (no back/forward buttons)
- `workbench.layoutControl.type`: "menu" (dropdown instead of toggles)
- `workbench.activityBar.location`: bottom (compact, under primary side bar)

**Layout (UI only, View → Appearance / Customize Layout):**

- Quick input position: center
- Panel alignment: justify (full window width)
- Secondary side bar: right (`Cmd+Option+B`)

## Applications List Maintenance

When updating the Applications table in README.md, see the selection criteria documented there. Key guidelines:

- Tools in **bold** are primary recommendations (one per category)
- GUI apps go in Applications section, text-based/TUI tools go in CLI Tools section
- Include 3-5 apps per category when possible
- Verify apps are actively maintained before adding
- Research community sentiment (Reddit, GitHub issues, HN) before adding new tools

## Cross-Config Consistency Rules

When modifying any config file, ensure these values stay consistent across all tools:

| Setting | VSCode | Zed | Micro | Ghostty | Bat | Delta | Yazi |
|---|---|---|---|---|---|---|---|
| Tab size | `editor.tabSize: 4` | `tab_size: 4` | `tabsize: 4` | — | `--tabs=4` | `tabs = 4` | `tab_size = 4` |
| Spaces (not tabs) | `editor.insertSpaces: true` | `hard_tabs: false` | `tabstospaces: true` | — | — | — | — |
| Final newline | `files.insertFinalNewline: true` | `ensure_final_newline_on_save: true` | `eofnewline: true` | — | — | — | — |
| Trim trailing WS | `files.trimTrailingWhitespace: true` | `remove_trailing_whitespace_on_save: true` | `rmtrailingws: true` | — | — | — | — |
| EOL | `files.eol: "\n"` | (default LF on macOS) | `fileformat: "unix"` | — | — | — | — |
| Word wrap | `editor.wordWrap: "off"` | `soft_wrap: "none"` | `wordwrap: false` | — | — | — | `wrap = "no"` |
| Scroll margin | `editor.cursorSurroundingLines: 3` | `vertical_scroll_margin: 3` | `scrollmargin: 3` | — | — | — | `scrolloff = 3` |
| Line height | `editor.lineHeight: 1.5` | `buffer_line_height: "comfortable"` (1.618) | — | — | — | — | — |
| Cursor | `cursorStyle: "line"`, width 2 | `cursor_shape: "bar"` | — | `cursor-style = bar`, thickness 2 | — | — | — |
| Cursor blink | `cursorBlinking: "smooth"` | `cursor_blink: true` | — | `cursor-style-blink = true` | — | — | — |
| Font | JetBrains Mono 14pt + fallbacks | Same chain | (terminal font) | Same chain | — | — | — |
| Ligatures | `editor.fontLigatures: true` | `buffer_font_features: null` (all on) | — | (default: on) | — | — | — |
| Theme (dark) | Catppuccin Macchiato | Catppuccin Macchiato | — | Catppuccin Macchiato | Catppuccin Macchiato | Catppuccin Macchiato | — |
| Theme (light) | Catppuccin Latte | Catppuccin Latte | — | — | — | — | — |
| Minimap | `minimap.enabled: false` | `minimap.show: "never"` | — | — | — | — | — |
| Rulers/Guides | `rulers: [80, 120]` | `wrap_guides: [80, 120]` | `colorcolumn: 80` | — | — | — | — |
| Sticky scroll | `stickyScroll.enabled: true` | `sticky_scroll.enabled: true` | — | — | — | — | — |
| Bracket colors | `bracketPairColorization.enabled: true` | `colorize_brackets: true` | `matchbrace: true` | — | — | — | — |
| Linked editing | `linkedEditing: true` | `linked_edits: true` | — | — | — | — | — |
| Whitespace | `renderWhitespace: "selection"` | `show_whitespaces: "selection"` | — | — | — | — | — |
| Line highlight | `renderLineHighlight: "all"` | `current_line_highlight: "all"` | `cursorline: true` | — | — | — | — |
| Semantic tokens | `semanticHighlighting.enabled: true` | `semantic_tokens: "combined"` | — | — | — | — | — |
| Hover delay | `editor.hover.delay: 200` | `hover_popover_delay: 200` | — | — | — | — | — |
| Option as Meta | `terminal.macOptionIsMeta: true` | `terminal.option_as_meta: true` | — | `macos-option-as-alt = true` | — | — | — |
| Git protocol | `github.gitProtocol: "ssh"` | — | — | — | — | — | — |
| Git pager | — | — | — | — | — | `pager = delta` | — |
| Git blame | `git.blame.enabled: true` (author+date) | `inline_blame.enabled: true`, `show_commit_summary: false` | — | — | — | — | — |
| Show hidden | — | — | — | — | — | — | `show_hidden = true` |
| Follow symlinks | `search.followSymlinks: true` | — | — | — | — | — | — |
| Nerd fonts | Font fallback chain | Font fallback chain | — | Font fallback chain | — | — | — |
| Icons | `workbench.iconTheme` | `icon_theme` | — | — | — | — | (auto-detected) |
| Format on save | `editor.formatOnSave: true` | `format_on_save: "on"` | — | — | — | — | — |
| Auto save | `files.autoSave: "off"` | `autosave: "off"` | — | — | — | — | — |
| Detect indent | `editor.detectIndentation: true` | (default: true) | — | — | — | — | — |
| Auto indent on paste | `editor.autoIndentOnPaste: true` | `auto_indent_on_paste: true` | `smartpaste: true` | — | — | — | — |
| Inlay hints | `editor.inlayHints (enabled)` | `inlay_hints.enabled: true` | — | — | — | — | — |
| Close on file delete | `closeOnFileDelete: true` | `close_on_file_delete: true` | — | — | — | — | — |
| Auto-close brackets | `autoClosingBrackets: "languageDefined"` | `use_autoclose: true` | — | — | — | — | — |
| Completions on input | `editor.quickSuggestions: "on"` | `show_completions_on_input: true` | — | — | — | — | — |
| Syntax highlighting | — | — | `syntax: true` | — | — | — | — |
| Encoding | — | — | `encoding: "utf-8"` | — | — | — | — |
| Truecolor | — | — | `truecolor: "auto"` | — | — | — | — |
| Param hints | `parameterHints.enabled: true` | `auto_signature_help: true` | — | — | — | — | — |
| Completion docs | `editor.suggest.preview: true` | `show_completion_documentation: true` | — | — | — | — | — |
| Git gutter | (default: on) | `git.git_gutter: "tracked_files"` | `diffgutter: true` | — | `--style=changes` | — | — |
| Diff ignore WS | `diffEditor.ignoreTrimWhitespace: false` | — | — | — | — | (default: show) | — |
| Trim final NLs | `files.trimFinalNewlines: true` | (no equivalent — gap) | — | — | — | — | — |
| Auto indent | `editor.autoIndent: "full"` | (default: on) | `autoindent: true` | — | — | — | — |
| Format on paste | `editor.formatOnPaste: true` | — | `smartpaste: true` | — | — | — | — |
| Smart case search | — | `use_smartcase_search: true` | — | — | — | — | — |
| Dirs first | — | — | — | — | — | — | `sort_dir_first = true` |
| Inline diagnostics | ErrorLens extension | `diagnostics.inline.enabled: true` | — | — | — | — | — |
| Theme detection | `autoDetectColorScheme: true` | `theme.mode: "system"` | — | — | — | — | — |

**Telemetry** — minimize across all tools:

| Tool | Setting | Value |
|---|---|---|
| VSCode | `telemetry.telemetryLevel` | `"crash"` |
| VSCode | `redhat.telemetry.enabled` | `false` |
| Zed | `telemetry.diagnostics` / `metrics` | `true` / `false` |
| Claude Code | `feedbackSurveyRate` | `0` |
| Codex | `analytics.enabled` / `feedback.enabled` | `false` / `false` |

**File search/listing tools** must stay in sync across: `fd` alias in `.zshrc`, `.ripgreprc`, yazi, eza aliases, Finder defaults

| Behavior | fd | rg | yazi | eza | Finder |
|---|---|---|---|---|---|
| Hidden files | `--hidden` | `--hidden` | `show_hidden = true` | `-a` (in `ll`/`lt`) | `AppleShowAllFiles` |
| Follow symlinks | `--follow` | `--follow` | `show_symlink = true` | — | — |
| Dirs first | — | — | `sort_dir_first = true` | `--group-directories-first` | `_FXSortFoldersFirst` |
| Case insensitive | — | `--smart-case` | `sort_sensitive = false` | — | — |

**Italic text rendering** must stay consistent:

- VSCode Catppuccin: `italicComments: true`, `italicKeywords: true`
- bat: `--italic-text=always`
- Delta inherits from bat theme engine (Catppuccin Macchiato italic support)

**Smooth scrolling** enabled everywhere:

- VSCode: `editor.smoothScrolling`, `workbench.list.smoothScrolling`, `terminal.integrated.smoothScrolling` (all `true`)
- Zed: native smooth scrolling (macOS)
- Ghostty: native smooth scrolling (macOS)

**AI agent** enabled in both editors:

- VSCode: `chat.agent.enabled: true`
- Zed: `agent.enabled: true`

**Modified file indicators** in tabs:

- VSCode: `workbench.editor.highlightModifiedTabs: true`
- Zed: `tabs.git_status: true`
- Micro: `diffgutter: true`

**Line numbers in preview tools** (consistent with editors showing line numbers):

- bat: `--style="numbers,changes,header,grid"`
- Delta: `line-numbers = true`

**Window/system theme follows OS:**

- Ghostty: `window-theme = system`
- Zed: `theme.mode: "system"` (light: Catppuccin Latte, dark: Catppuccin Macchiato)
- VSCode: `window.autoDetectColorScheme: true` (light: Catppuccin Latte, dark: Catppuccin Macchiato)

**Inline diagnostics** (errors/warnings shown on affected lines):

- VSCode: `errorlens` extension (installed via Brewfile)
- Zed: `diagnostics.inline.enabled: true` (built-in, matches ErrorLens behavior)

**Extension management** — reproducible across machines:

- VSCode: `vscode` entries in `.Brewfile.core` (managed by `brew bundle dump` / `brew bundle install`)
- Zed: `auto_install_extensions` in `.config/zed/settings.json` (auto-installed on launch)

**Parameter hints / signature help:**

- VSCode: `editor.parameterHints.enabled: true`
- Zed: `auto_signature_help: true` (Zed default is `false`, overridden to match VSCode)

**Git changes gutter** (diff indicators in editor/preview):

- VSCode: git gutter enabled by default
- Zed: `git.git_gutter: "tracked_files"`
- Micro: `diffgutter: true`
- bat: `--style="numbers,changes,header,grid"` (`changes` = git diff markers)

**Diff whitespace handling:**

- VSCode: `diffEditor.ignoreTrimWhitespace: false` (show whitespace diffs)
- Delta: shows whitespace changes by default (no `--ignore-all-space`)

**Trim final newlines:**

- VSCode: `files.trimFinalNewlines: true` (trims extra blank lines at EOF)
- Zed: `ensure_final_newline_on_save: true` (adds one, does NOT trim extras — known gap)
- Micro: `eofnewline: true` (adds one, does not trim extras)

**Hidden files at shell level:**

- zsh: `setopt globdots` (glob matches dotfiles — consistent with fd/rg `--hidden`)
- fd/rg: `--hidden`
- yazi: `show_hidden = true`

**Case-insensitive matching across tools:**

- rg: `--smart-case`
- Zed: `use_smartcase_search: true`
- yazi: `sort_sensitive = false`
- zsh completions: `matcher-list 'm:{a-zA-Z}={A-Za-z}'`

**Shell integration:**

- Ghostty: `shell-integration = zsh`
- `.zshrc`: sources fzf (`fzf --zsh`), fnm, uv, zoxide, starship

**Clipboard whitespace:**

- Ghostty: `clipboard-trim-trailing-spaces = true` (trim on copy)
- Editors: trim trailing whitespace on save (VSCode, Zed, Micro)

**Update channel:** stable everywhere

- Claude Code: `autoUpdatesChannel: "stable"`
- Ghostty: `auto-update-channel = stable`

**Codex ↔ Claude shared docs:** Codex `project_doc_fallback_filenames = ["CLAUDE.md"]` — both agents read same `CLAUDE.md` files

**Exclusion lists** must stay in sync across: `.ripgreprc`, `fd` alias in `.zshrc`, VSCode `search.exclude`, Zed `file_scan_exclusions`, `.gitignore_global`

Core exclusions: `.git`, `node_modules`, `.venv`, `venv`, `__pycache__`, `.pytest_cache`, `.terraform`, `vendor`, `dist`, `build`, `coverage`

**Git settings** must stay consistent across: `.gitconfig` (authoritative), VSCode, Zed, `gh` CLI, lazygit

| Setting | `.gitconfig` | VSCode | gh CLI | lazygit | Zed |
|---|---|---|---|---|---|
| Protocol | `url.insteadOf` (SSH) | `gitProtocol: "ssh"` | `git_protocol: ssh` | (uses git) | (uses git) |
| Pager | `core.pager = delta` | — | `pager: delta` | `delta --paging=never` | — |
| Delta theme | `delta.syntax-theme` | — | — | — | — |
| Auto fetch | — | `autofetch: true` (300s) | — | `autoFetch: true` (60s) | no setting (gap) |
| Prune on fetch | `fetch.prune = true` | `pruneOnFetch: true` | — | — | (uses git) |
| Rebase on pull | `pull.rebase = true` | `rebaseWhenSync: true` | — | — | (uses git) |
| Autostash | `rebase.autostash = true` | `autoStash: true` | — | — | (uses git) |
| Branch protection | — | `branchProtection: [main, master]` | — | `disableForcePushing: true` | no setting (gap) |
| Inline blame | — | `blame.enabled: true` | — | — | `inline_blame.enabled: true` |
| Blame format | — | `${authorName} (${authorDateAgo})` | — | — | `show_commit_summary: false` |
| Editor | `core.editor = code --wait` | — | — | `editPreset: vscode` | — |
| Nerd fonts | — | — | — | `nerdFontsVersion: "3"` | — |

Zed delegates git workflow (rebase, autostash, prune, SSH) to `.gitconfig` — consistent by inheritance. Two known gaps: no auto-fetch, no branch protection.

**Git config** (`.gitconfig` authoritative for all git tools):

- Default branch: `init.defaultBranch = main`
- Merge conflicts: `merge.conflictstyle = zdiff3`
- Rerere: `rerere.enabled = true`, `rerere.autoupdate = true`
- Push: `push.autoSetupRemote = true`
- Diff: `algorithm = histogram`, `colorMoved = default`, `renames = true`, `mnemonicPrefix = true`
- Delta: `dark = true`, `line-numbers = true`, `side-by-side = true`, `hyperlinks = true`, `navigate = true`
- Log: `date = relative`
- Branch: `sort = -committerdate`

**`EDITOR` env var** must match across: `.zprofile` (`code --wait`), `.gitconfig` (`core.editor`), lazygit (`editPreset: vscode`), Codex (`file_opener = "vscode"`)

**Claude ↔ Codex** allowed commands must stay in sync between `.claude/settings.json` and `.codex/rules/`

## Claude Code Settings

The `.claude/settings.json` configures permissions and plugins:

- **Allowed:** Read-only git/docker/k8s, build/test/lint tools, web search, web fetch from dev docs (GitHub, Stack Overflow, MDN, Go/Python/Node/Terraform/Docker/Kubernetes/Claude docs), `fd` and `rg` for file search
- **Denied:** `.env`, `.ssh/*`, `.kube/config`, `.git-credentials`, credentials, private keys, `.tfvars`
- **Requires approval:** Package install, direct code execution, git writes, docker mutations
- **Enabled plugins:** pyright-lsp, gopls-lsp, typescript-lsp, code-review, feature-dev, code-simplifier, claude-md-management, caveman
- **Marketplace:** [caveman](https://github.com/JuliusBrussee/caveman) (auto-update enabled)
- **Status line:** Custom layout via `ccstatusline` (model, thinking effort, cwd, git branch, context %, session/weekly usage, cost)
- **Usage tracking:** `ccusage` via npx for token usage and cost analysis

See `.claude/settings.json` for the full permission list.

## Codex Settings

The `.codex/config.toml` configures model selection, sandboxing, profiles, plugins, and MCP integrations:

- **Default behavior:** On-request approvals, `workspace-write` sandbox, cached web search by default, analytics/feedback disabled
- **Profiles:** `quick`, `deep`, and `research` (`research` enables live web search)
- **Rules:** `.codex/rules/` defines allowed command groups for `git`, `dev`, `shell`, and `infra`
- **Enabled plugins:** Slack, caveman
- **Marketplace:** [caveman](https://github.com/JuliusBrussee/caveman)
- **MCP servers:** Atlassian, Datadog

See `.codex/config.toml` and `.codex/rules/` for the full configuration.
