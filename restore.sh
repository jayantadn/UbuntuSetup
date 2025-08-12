#!/bin/bash

## Detect if running on WSL or native Ubuntu
if grep -qi microsoft /proc/version; then
    ubuntu_env="wsl"
    echo "Detected WSL environment."
else
    ubuntu_env="native"
    echo "Detected native Ubuntu environment."
fi

## Common for WSL and native

# initial steps
sudo apt update && sudo apt upgrade -y

# git configure
git config --global user.name "Jayanta Debnath"
git config --global user.email Jayanta.Dn@gmail.com


# setup command prompt
echo "export PS1='\\[\\e[35m\\][\\A]\\[\\e[0m\\] \\[\\e[34m\\]\\W\\[\\e[0m\\] \\$ '" >> ~/.bashrc

# install python 3.10
sudo apt install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
cd /usr/src
sudo wget https://www.python.org/ftp/python/3.10.13/Python-3.10.13.tgz
sudo tar xvf Python-3.10.13.tgz
sudo rm Python-3.10.13.tgz
cd Python-3.10.13
sudo ./configure --enable-optimizations
sudo make -j$(nproc)
sudo make altinstall
sudo rm -rf /usr/src/Python-3.10.13

## WSL specific
if [ "$ubuntu_env" = "wsl" ]; then
    echo "Running WSL-specific setup..."
fi

## Native Ubuntu specific
if [ "$ubuntu_env" = "native" ]; then
    # timesync fix
    sudo timedatectl set-timezone Asia/Kolkata

    # set grub timeout as 3s
    GRUB_CFG_FILE="/etc/default/grub"
    sudo cp "$GRUB_CFG_FILE" "${GRUB_CFG_FILE}.bak.$(date +%Y%m%d%H%M%S)"
    if grep -q "^GRUB_TIMEOUT=" "$GRUB_CFG_FILE"; then
        sudo sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=3/' "$GRUB_CFG_FILE"
    else
        echo "GRUB_TIMEOUT=3" | sudo tee -a "$GRUB_CFG_FILE" > /dev/null
    fi
    sudo update-grub

    # install Joplin
    wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash

    # insltall vscode
    sudo apt install -y wget gpg apt-transport-https software-properties-common
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/packages.microsoft.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
    https://packages.microsoft.com/repos/code stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
    sudo apt update
    sudo apt install -y code

fi
