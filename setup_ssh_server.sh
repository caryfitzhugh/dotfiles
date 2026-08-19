#!/usr/bin/env bash
set -e

echo "==> Checking Tailscale..."
if ! command -v tailscale >/dev/null 2>&1; then
    echo "ERROR: Tailscale is not installed in this WSL instance."
    exit 1
fi

if ! tailscale status >/dev/null 2>&1; then
    echo "ERROR: Tailscale is not running/authenticated."
    echo "Run: sudo tailscale up"
    exit 1
fi

echo "==> Enabling Tailscale SSH..."
sudo tailscale set --ssh

echo
echo "==> Tailscale SSH is enabled."
echo
echo "Tailscale IP:"
tailscale ip -4

echo
echo "Hostname:"
tailscale status --self
