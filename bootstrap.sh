#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────
# dev-bootstrap — macOS / Linux / WSL
# Homebrew + mise + uv. Auto-detects the OS. Safe to re-run.
# (Native Windows uses bootstrap-gitbash.sh instead.)
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

# 1. Detect OS
case "$(uname -s)" in
  Darwin) OS=macos ;;
  Linux)  grep -qi microsoft /proc/version 2>/dev/null && OS=wsl || OS=linux ;;
  *) echo "Unsupported OS: $(uname -s)"; exit 1 ;;
esac
log "Target: $OS"

# 2. Linux/WSL: apt prerequisites for Homebrew (+ wslview on WSL for browser auth)
if [[ "$OS" != macos ]]; then
  log "Installing apt prerequisites (sudo, once)"
  sudo apt-get update -qq
  sudo apt-get install -y build-essential procps curl file git
  [[ "$OS" == wsl ]] && sudo apt-get install -y wslu
fi

# 3. Homebrew (asks for sudo at install time only; never after)
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
[[ -x /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -x /home/linuxbrew/.linuxbrew/bin/brew ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# 4. Packages
log "brew bundle: Brewfile"
brew bundle --file "$REPO_DIR/Brewfile"
if [[ "$OS" == macos ]]; then
  log "brew bundle: Brewfile.macos"
  brew bundle --file "$REPO_DIR/Brewfile.macos"
else
  log "Installing gcloud (Linux/WSL)"
  bash "$REPO_DIR/scripts/cloud.sh"
fi

# 5. Runtimes (mise)
log "Runtimes (mise)"
link "$REPO_DIR/config/mise/config.toml" "$HOME/.config/mise/config.toml"
mise install

# 6. Python tools (uv)
log "Python tools (uv)"
bash "$REPO_DIR/scripts/python-tools.sh"

# 7. Shell config
log "Linking zsh config"
link "$REPO_DIR/config/starship.toml"        "$HOME/.config/starship.toml"
link "$REPO_DIR/config/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"
link "$REPO_DIR/config/zsh/.zshrc"           "$HOME/.zshrc"

# 8. Done
[[ "${SHELL:-}" == *zsh ]] || log "Set zsh as default:  chsh -s \"$(command -v zsh)\""
[[ "$OS" == wsl ]] && warn "Keep repos in the Linux FS (~/...), NOT /mnt/c/... — that path is slow."
log "Done. Start a fresh shell:  exec zsh"
