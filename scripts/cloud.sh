#!/usr/bin/env bash
# gcloud install for Linux / WSL (on macOS it comes from Brewfile.macos cask).
set -euo pipefail

if command -v gcloud >/dev/null 2>&1; then
  echo "gcloud already installed: $(gcloud --version | head -1)"
  exit 0
fi

echo "Installing Google Cloud SDK via official installer into \$HOME ..."
curl -fsSL https://sdk.cloud.google.com | bash -s -- --disable-prompts
echo "Restart your shell, then run: gcloud init"
