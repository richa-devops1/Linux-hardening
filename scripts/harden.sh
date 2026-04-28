#!/bin/bash

echo "🔐 Starting Linux Hardening (CentOS)..."

# 1. Update system
echo "Updating system..."
sudo yum update -y

# 2. Disable root SSH login
echo "Disabling root login..."
sudo sed -i 's/^#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config

# 3. Disable password authentication
echo "Disabling password authentication..."
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# 4. Restart SSH service
sudo systemctl restart sshd

# 5. Install and configure firewall (firewalld)
echo "Setting up firewall..."
sudo yum install firewalld -y
sudo systemctl enable firewalld
sudo systemctl start firewalld

# Allow SSH, HTTP, HTTPS
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --reload

# 6. Install Fail2Ban (EPEL required)
echo "Installing Fail2Ban..."
sudo yum install epel-release -y
sudo yum install fail2ban -y

sudo systemctl enable fail2ban
sudo systemctl start fail2ban

echo "✅ Hardening Completed!"
