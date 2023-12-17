#!/bin/sh

echo "Install packages"
sudo apt-get install iputils-ping

echo "Upgrading pip"
pip install --upgrade pip

echo "Installing ANTA package from git"
pip install -r requirements.txt

echo "Installing ansible requirements"
ansible-galaxy collection install -r collections.yml
