# dev-bootstrap

Reproducible developer environment. **Homebrew + mise + uv** on every Unix-like
machine (macOS, Linux, WSL); **scoop** on native Windows. Principle: declarative
manifests, thin bootstrap — re-run any time, it's idempotent.

## The three tools

- **Homebrew** — standalone CLI programs (git, ripgrep, jq, starship, duckdb…) plus macOS GUI apps.
- **mise** — language runtimes (Node, Terraform, Go) and their versions.
- **uv** — Python: interpreter, venvs, project deps, and Python CLI tools (ruff, dbt).

Rule of thumb: **Python → uv, runtimes → mise, everything else → Homebrew.**

## Quickstart

**macOS / Linux / WSL**
```bash
git clone <your-repo> ~/dev-bootstrap && cd ~/dev-bootstrap
./bootstrap.sh
exec zsh
```
On Windows, run that inside WSL (`wsl --install -d Ubuntu` first).

**Native Windows (Git Bash)** — lighter, bash-only:
```bash
./bootstrap-gitbash.sh
```

## What gets installed

| Layer | Tools |
|---|---|
| Python | uv |
| Runtimes | mise → Node LTS (Terraform/Go pinned per-project) |
| Prompt | starship |
| Shell (zsh) | sheldon + fast-syntax-highlighting + zsh-autosuggestions + carapace |
| Terminal | ripgrep, fd, bat, eza, fzf, zoxide, jq, yq, delta, direnv, zellij, btop, tldr |
| Data/cloud | duckdb, libpq (psql), gcloud, dbt (via uv tool) |
| Python tools | ruff, pre-commit, mypy, dbt-core+dbt-bigquery |

## File map

```
bootstrap.sh            macOS / Linux / WSL  (Homebrew + mise + uv, auto-detect)
bootstrap-gitbash.sh    native Windows       (scoop, bash-only)
Brewfile                shared formulae
Brewfile.macos          macOS-only casks (OrbStack, gcloud, Nerd Font)
config/mise/config.toml runtimes
config/starship.toml    prompt (shared by zsh + bash)
config/sheldon/plugins.toml  zsh plugins
config/zsh/.zshrc       zsh glue (macOS / Linux / WSL)
config/bash/.bashrc     bash glue (Git Bash)
scripts/python-tools.sh uv tool installs
scripts/cloud.sh        gcloud installer (Linux / WSL)
```

## Adding a tool later

- CLI program → one `brew "..."` line in `Brewfile`, re-run `brew bundle`.
- Runtime → `config/mise/config.toml`, then `mise install`.
- Python tool → `scripts/python-tools.sh`.

No script logic ever changes.

## Notes

- **Homebrew on Linux/WSL** installs once; it asks for sudo at install time only,
  never after. The apt prerequisites are installed for you. ARM64 is supported as
  of Homebrew 5.0; 32-bit Pi OS is not — check with `uname -m` (you want `aarch64`).
- **Nerd Font** needed for starship glyphs (the macOS cask installs one;
  elsewhere install any Nerd Font and set it in your terminal).
- **Git Bash** can't run Homebrew or the zsh plugins; it gets starship + the CLI
  tools via scoop. Use WSL for real work. The one PowerShell touch (scoop's own
  installer) is driven for you from bash.
- **Container runtime** is not auto-installed (heavy, OS-divergent): OrbStack on
  macOS; Docker/Podman on Linux; Docker Desktop WSL integration on Windows.

## Optional upgrades

- Dotfiles → **chezmoi** (templated, OS-aware); bootstrap becomes `chezmoi init --apply`.
- Shell history → **atuin** (synced DB) — left out per preference; one line to add later.
