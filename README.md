# .config (macOS)

macOS configuration files, branched from `main`.

## Setup

Clone the `macos` branch into `~/.config` and run the bootstrap script:

```bash
~/.config/_bootstrap.sh
```

`_bootstrap.sh` installs Homebrew (if missing), installs packages from `Brewfile`, configures `~/.zshenv` with `ZDOTDIR="$HOME/.config/zsh"`, and installs `mise` and its configured runtimes.

## Zsh

Zsh configuration lives in `zsh/` and is split into `.zshrc`, `fzf.zsh`, and `aliases.zsh`. Machine-specific overrides can be placed in `zsh/local.zsh`, which is sourced automatically if present.

## Tracking New Configs

`.gitignore` ignores all files by default. To track a new file or directory, add an explicit `!path` rule to `.gitignore` or use `git add -f <path>`.
