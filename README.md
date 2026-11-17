# .config (PikaOS)

PikaOS desktop and CLI configuration files, branched from `main`.

## Setup

Clone the `pikaos` branch into `~/.config` and run the bootstrap script:

```bash
~/.config/_bootstrap.sh
```

`_bootstrap.sh` installs required packages via `pikman`, configures `~/.zshenv` with `ZDOTDIR="$HOME/.config/zsh"`, and installs `mise` and its configured runtimes.

## Package Management

System packages and CLI tools (`bat`, `eza`, `fastfetch`, `fzf`, `gh`, `git`, `ghostty`, `zsh`) are installed via `pikman` in `_bootstrap.sh`. Language runtimes (`java`, `maven`, `node`) are managed via `mise` in `mise/config.toml`.

## Zsh

Zsh configuration lives in `zsh/` and is split into `.zshrc`, `fzf.zsh`, and `aliases.zsh`. Machine-specific overrides (such as the Noctalia `fzf` theme) live in `zsh/local.zsh`, which is sourced automatically if present.

## Tracking New Configs

`.gitignore` ignores all files by default. To track a new file or directory, add an explicit `!path` rule to `.gitignore` or use `git add -f <path>`.
