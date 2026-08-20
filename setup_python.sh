#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing system prerequisites..."
sudo apt-get update
sudo apt-get install -y \
    curl \
    ca-certificates \
    build-essential \
    pkg-config \
    libssl-dev \
    libffi-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    liblzma-dev \
    tk-dev \
    xz-utils

echo "==> Installing uv..."
curl -LsSf https://astral.sh/uv/install.sh | sh

# Make uv available to this script immediately.
export PATH="$HOME/.local/bin:$PATH"

echo "==> Installing Python versions..."
uv python install 3.13
uv python install 3.14

echo
echo "==> Installed Python versions:"
uv python list --only-installed

echo
echo "==> uv:"
uv --version

echo
echo "============================================================"
echo "Python/uv installation complete."
echo
echo "Create a project:"
echo "    uv init myproject"
echo "    cd myproject"
echo
echo "Create a virtual environment:"
echo "    uv venv"
echo
echo "Use Python 3.14:"
echo "    uv python pin 3.14"
echo
echo "Install packages:"
echo "    uv add requests"
echo "============================================================"
