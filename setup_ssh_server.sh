#!/usr/bin/env bash
set -e

echo "==> Installing OpenSSH server..."
sudo apt update
sudo apt install -y openssh-server

echo "==> Generating SSH host keys if necessary..."
sudo ssh-keygen -A

echo "==> Configuring sshd..."
sudo tee /etc/ssh/sshd_config.d/99-wsl.conf >/dev/null <<'EOF'
Port 22
PasswordAuthentication no
PubkeyAuthentication yes
PermitRootLogin no
EOF

echo "==> Checking configuration..."
sudo sshd -t

echo "==> Starting SSH server..."
if command -v systemctl >/dev/null 2>&1 && systemctl is-system-running >/dev/null 2>&1; then
    sudo systemctl enable --now ssh
else
    sudo service ssh start
fi

echo
echo "==> SSH server status:"
sudo service ssh status --no-pager || true

echo
echo "==> Listening on:"
sudo ss -lntp | grep ':22' || true

echo
echo "Done."
echo "Username: $(whoami)"
echo
echo "Next: put your PUBLIC SSH keys in:"
echo "  ~/.ssh/authorized_keys"
