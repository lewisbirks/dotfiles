# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install

export PATH="$HOME/.local/bin:$PATH"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# Initialize Zsh's built-in completion system before fzf-tab
autoload -Uz compinit && compinit

# Enable multi-column grid layout & case-insensitive fuzzy matching
zstyle ':completion:*' list-packed true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:descriptions' format '[%d]'

zinit light-mode depth"1" for \
    romkatv/powerlevel10k \
    Aloxaf/fzf-tab \
    zsh-users/zsh-autosuggestions \
    zdharma-continuum/fast-syntax-highlighting

# Configure fzf-tab popup height and layout
# Style fzf & fzf-tab using Ghostty's native ANSI palette and transparency
export FZF_DEFAULT_OPTS=" \
  --height=40% \
  --layout=reverse \
  --border=rounded \
  --info=inline-right \
  --prompt='❯ ' \
  --pointer='▶' \
  --marker='✓' \
  --color=bg:-1,bg+:0,fg:-1,fg+:15 \
  --color=hl:4,hl+:12,info:3,marker:2 \
  --color=prompt:5,spinner:5,pointer:5,header:6 \
  --color=border:8,label:8,query:15"

if [[ -f /etc/os-release ]] && grep -q '^ID=pika$' /etc/os-release && [[ -f "$HOME/.config/fzf/themes/noctalia.sh" ]]; then
  source "$HOME/.config/fzf/themes/noctalia.sh"
fi

# Tell fzf-tab to use FZF_DEFAULT_OPTS and clean up group headers
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'
# Show a right-hand preview panel with wrap enabled (toggle with Ctrl+/)
zstyle ':fzf-tab:*' fzf-flags --height=45% --layout=reverse --border=rounded \
  --preview-window=right:50%:wrap \
  --bind='ctrl-/:toggle-preview'

# Render directory trees with eza and file contents with bat/batcat
zstyle ':fzf-tab:complete:*:*' fzf-preview '
  if [[ -d $realpath ]]; then
    eza -1 --tree --level=2 --color=always --icons=always "$realpath" 2>/dev/null || ls -la --color=always "$realpath"
  elif [[ -f $realpath ]]; then
    bat --color=always --style=numbers --line-range=:200 "$realpath"
  fi
'

# override ls to use eza instead
alias ls='eza --icons=auto --group-directories-first'
alias ll='eza -lh --icons=auto --group-directories-first --git'
alias tree='eza --tree --icons=auto'

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f "${ZDOTDIR:-$HOME}/.p10k.zsh" ]] || source "${ZDOTDIR:-$HOME}/.p10k.zsh"
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
elif [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$("$HOME/.local/bin/mise" activate zsh)"
fi
