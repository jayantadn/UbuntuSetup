#!/bin/bash

echo "Running WSL-specific setup..."

# install thunar filemanager
sudo apt install thunar
sudo apt install thunar-archive-plugin
sudo apt install file-roller
sudo apt install zip unzip p7zip-full rar unrar
sudo apt install -y xfce4-terminal xterm

# install other GUI tools
sudo apt install gedit
