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

# Tell fzf-tab to use FZF_DEFAULT_OPTS and clean up group headers
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

# Show a right-hand preview panel with wrap enabled (toggle with Ctrl+/)
zstyle ':fzf-tab:*' fzf-flags --height=45% --layout=reverse --border=rounded \
  --preview-window=right:50%:wrap \
  --bind='ctrl-/:toggle-preview'

# Render directory trees with eza and file contents with bat
zstyle ':fzf-tab:complete:*:*' fzf-preview '
  if [[ -d $realpath ]]; then
    eza -1 --tree --level=2 --color=always --icons=always "$realpath" 2>/dev/null || ls -la --color=always "$realpath"
  elif [[ -f $realpath ]]; then
    bat --color=always --style=numbers --line-range=:200 "$realpath"
  fi
'
