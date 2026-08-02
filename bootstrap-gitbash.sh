#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
# dev-bootstrap — native Windows (Git Bash)
# scoop-based, bash-only. Reduced vs WSL: no Homebrew, no zsh plugins.
# For the full stack, use WSL + ./bootstrap.sh.
# ─────────────────────────────────────────────────────────────
set -euo pipefail
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log()  { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!\033[0m  %s\n' "$*"; }
link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    mv "$dst" "$dst.backup.$(date +%s)"; log "Backed up $(basename "$dst")"
  fi
  ln -sf "$src" "$dst"
}

# 1. scoop — the only step that touches PowerShell (driven from bash, one-off)
if ! command -v scoop >/dev/null 2>&1; then
  log "Installing scoop (one-time)"
  powershell -NoProfile -Command \
    "Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force; irm get.scoop.sh | iex"
  export PATH="$HOME/scoop/shims:$PATH"
fi

# 2. Tools (verify names with `scoop search <tool>`; some live in extras)
scoop bucket add main   >/dev/null 2>&1 || true
scoop bucket add extras >/dev/null 2>&1 || true
scoop install uv mise starship carapace gh \
  ripgrep fd bat eza fzf zoxide jq yq delta duckdb nodejs-lts

# 3. Python tools (uv runs natively on Windows)
log "Python tools (uv)"
bash "$REPO_DIR/scripts/python-tools.sh"

# 4. Runtimes + bash shell config
link "$REPO_DIR/config/mise/config.toml" "$HOME/.config/mise/config.toml"
mise install || warn "mise install had issues — see README Windows notes"
link "$REPO_DIR/config/starship.toml"    "$HOME/.config/starship.toml"
link "$REPO_DIR/config/bash/.bashrc"     "$HOME/.bashrc"

log "Done. Restart Git Bash."
log "Want the full stack (zsh + Homebrew + plugins)? Use WSL:  ./bootstrap.sh"
