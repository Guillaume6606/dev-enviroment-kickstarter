# ─────────────────────────────────────────────────────────────
# Managed by dev-bootstrap. Symlinked to ~/.zshrc.
# ─────────────────────────────────────────────────────────────

# Homebrew (macOS Apple Silicon, then Linux/WSL)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# WSL: route browser-opening CLIs (gcloud, gh) to the Windows browser
if grep -qi microsoft /proc/version 2>/dev/null; then
  command -v wslview >/dev/null && export BROWSER=wslview
fi

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS

# Completions (must run before carapace / plugins)
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"

# Runtime manager
command -v mise >/dev/null && eval "$(mise activate zsh)"

# Cross-shell completions
command -v carapace >/dev/null && source <(carapace _carapace zsh)

# Plugins (fast-syntax-highlighting, zsh-autosuggestions) via sheldon
command -v sheldon >/dev/null && eval "$(sheldon source)"

# Smart cd
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# Fuzzy finder key bindings + completion (fzf >= 0.48)
command -v fzf >/dev/null && source <(fzf --zsh)

# Per-directory env / auto venv activation
command -v direnv >/dev/null && eval "$(direnv hook zsh)"

# Aliases
alias ls='eza --group-directories-first'
alias ll='eza -lah --group-directories-first --git'
alias cat='bat --paging=never'
alias cd='z'

# Prompt (load last)
command -v starship >/dev/null && eval "$(starship init zsh)"
