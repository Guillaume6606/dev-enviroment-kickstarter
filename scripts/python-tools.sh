#!/usr/bin/env bash
# Global Python tools, installed in isolated environments via uv.
# Idempotent: re-running upgrades / no-ops.
set -euo pipefail

uv tool install ruff                          # lint + format (black/flake8/isort)
uv tool install pre-commit
uv tool install mypy                          # type checker (or: uv tool install pyright)
uv tool install dbt-core --with dbt-bigquery  # dbt isolated, with the BQ adapter

# Optional extras — uncomment as needed:
# uv tool install posting     # TUI API client for poking FastAPI services
# uv tool install httpie
