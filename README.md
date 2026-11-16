# .config

Personal configuration files for PikaOS and macOS.

## Setup

Clone this repository into `~/.config` and run the bootstrap script:

```bash
~/.config/_bootstrap.sh
```

`_bootstrap.sh` detects the current OS and delegates to the matching script in `_bootstrap/` (`pikaos.sh` or `macos.sh`) to install required CLI packages, configure `~/.zshenv` with `ZDOTDIR="$HOME/.config/zsh"`, and install `mise` runtimes.

Zsh configuration lives in `zsh/` and is split into `.zshrc`, `fzf.zsh`, and `aliases.zsh`. Machine-specific overrides can be placed in `zsh/local.zsh`, which is sourced automatically if present.

## Tracking New Configs

`.gitignore` ignores all files by default. To track a new file or directory, add an explicit `!path` rule to `.gitignore` or use `git add -f <path>`.
