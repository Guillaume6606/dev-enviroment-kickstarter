# Shared formulae — installed on macOS, Linux, and WSL via `brew bundle`.
# Casks (GUI apps) live in Brewfile.macos since they are macOS-only.

# === Core toolchain ===
brew "git"
brew "gh"
brew "uv"          # Python: versions, venvs, deps, lockfiles, global tools
brew "mise"        # Polyglot runtime manager (Node, Terraform, Go, ...)

# === Shell experience ===
brew "starship"    # Prompt (replaces powerlevel10k)
brew "sheldon"     # Lean zsh plugin manager (TOML config)
brew "carapace"    # Cross-shell completion engine

# === Terminal quality-of-life ===
brew "ripgrep"     # rg  — fast grep
brew "fd"          # fd  — fast find
brew "bat"         # bat — cat with syntax highlighting
brew "eza"         # eza — modern ls
brew "fzf"         # fuzzy finder
brew "zoxide"      # smart cd
brew "jq"          # JSON
brew "yq"          # YAML
brew "git-delta"   # readable git diffs
brew "direnv"      # per-directory env + auto venv activation
brew "zellij"      # terminal multiplexer (tmux is more portable server-side)
brew "btop"        # system monitor
brew "tlrc"        # tldr client

# === Data / cloud (CLI bits that install cleanly cross-OS) ===
brew "duckdb"      # local analytics on files / Parquet / BQ exports
brew "libpq"       # psql + libpq without the full Postgres server
# gcloud, Terraform/OpenTofu, Node, and container runtime are handled
# separately (mise for runtimes, scripts/cloud.sh for gcloud) — see README.
