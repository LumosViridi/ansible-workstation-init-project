#!/bin/bash

# Variables
PYTHON_VERSION=3.8

# Install HomeBrew if not already installed
echo "Checking to see if Homebrew is installed..."
if command -v which brew &> /dev/null; then
    echo "Homebrew is already installed."
else
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

#Update Homebrew
echo "Updating Homebrew..."
brew update

#Install Python
echo "Ensuring correct version of Python installed..."
echo "Installing Python $PYTHON_VERSION..."
brew install python@$PYTHON_VERSION

# Install Ansible using Homebrew
echo "Installing Ansible..."
brew install ansible python-packaging

echo "Prerequisites setup complete. You can now run the Ansible playbook."
