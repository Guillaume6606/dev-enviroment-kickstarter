# ─────────────────────────────────────────────────────────────
# Managed by dev-bootstrap. Git Bash / bash config (Windows).
# This is the REDUCED setup: bash, no zsh plugins. For the full
# experience (zsh + autosuggestions + highlighting), use WSL.
# ─────────────────────────────────────────────────────────────

# scoop shims on PATH
export PATH="$HOME/scoop/shims:$PATH"

# History
HISTSIZE=50000
HISTFILESIZE=50000
shopt -s histappend

# Runtime manager
command -v mise >/dev/null && eval "$(mise activate bash)"

# Cross-shell completions
command -v carapace >/dev/null && source <(carapace _carapace bash)

# Smart cd
command -v zoxide >/dev/null && eval "$(zoxide init bash)"

# Fuzzy finder (fzf >= 0.48)
command -v fzf >/dev/null && eval "$(fzf --bash)"

# Aliases
alias ls='eza --group-directories-first'
alias ll='eza -lah --group-directories-first --git'
alias cat='bat --paging=never'

# Optional: bash equivalent of the zsh plugins (syntax highlighting +
# autosuggestions) is ble.sh — uncomment after installing it:
#   https://github.com/akinomyoga/ble.sh
# [[ -f ~/.local/share/blesh/ble.sh ]] && source ~/.local/share/blesh/ble.sh

# Prompt (load last)
command -v starship >/dev/null && eval "$(starship init bash)"
