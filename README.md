# .config (Shared Base)

Shared base configuration files for Zsh, `mise`, `superfile`, and `gh`.

## Branches

- `main` — Shared base configurations (`zsh/`, `mise/`, `superfile/`, `gh/`).
- `pikaos` — PikaOS desktop and CLI configurations.
- `macos` — macOS CLI configurations.

Make shared changes on `main` and merge or rebase them into `pikaos` and `macos`.

## Zsh

Zsh configuration lives in `zsh/` and is split into `.zshrc`, `fzf.zsh`, and `aliases.zsh`. Machine-specific overrides can be placed in `zsh/local.zsh`, which is sourced automatically if present.

## Tracking New Configs

`.gitignore` ignores all files by default. To track a new file or directory, add an explicit `!path` rule to `.gitignore` or use `git add -f <path>`.
