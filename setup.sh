#!/bin/bash

# ==========================================
# Web2APK VPS Bootstrap Script
# ==========================================

echo -e "\n\033[36m🚀 STARTING VPS SETUP...\033[0m"

# 1. Update System & Install Basics
echo -e "\n\033[33m📦 Updating System & Installing Base Dependencies...\033[0m"
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit
fi

apt-get update -q
apt-get install -y curl wget git unzip zip build-essential libssl-dev

# 2. Install Node.js (Version 20.x)
if ! command -v node &> /dev/null; then
    echo -e "\n\033[33m📦 Installing Node.js v20...\033[0m"
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs
else
    echo -e "\n\033[32m✔ Node.js is already installed.\033[0m"
fi

# 3. Verify Node.js
NODE_VER=$(node -v)
echo -e "\n\033[32m✔ Node.js installed: $NODE_VER\033[0m"

# 4. Install Project Dependencies
echo -e "\n\033[33m📦 Installing Project Dependencies (npm install)...\033[0m"
npm install --no-audit --no-fund

# 5. Run Main Installer
echo -e "\n\033[36m🔧 Launching Internal Installer (install.js)...\033[0m"
node src/install.js
