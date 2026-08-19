#!/usr/bin/env bash
set -euo pipefail

echo "==> Installing Tailscale..."
curl -fsSL https://tailscale.com/install.sh | sh

echo "==> Enabling systemd in WSL..."
if ! grep -q '^[[:space:]]*systemd=true' /etc/wsl.conf 2>/dev/null; then
    cat >> /etc/wsl.conf <<'EOF'

[boot]
systemd=true
EOF
fi

echo "==> Enabling tailscaled..."
systemctl enable tailscaled

echo
echo "============================================================"
echo "Tailscale installed."
echo
echo "You need to restart WSL:"
echo
echo "    exit"
echo "    wsl --shutdown"
echo
echo "Then start WSL again and run:"
echo
echo "    sudo tailscale up"
echo
echo "Authenticate using the URL it provides."
echo
echo "After that, tailscaled will automatically start whenever"
echo "this WSL distro starts."
echo "============================================================"
