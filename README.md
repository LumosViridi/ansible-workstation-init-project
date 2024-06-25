# Developer Workstation Setup
## Overview

This project uses Ansible - <https://www.ansible.com/> and Homebrew - <https://brew.sh/> to more easily configure a developers workstation.

## TL;DR

Run on local workstation:

``` bash
# Ensure script is executable
chmod +x ./local-init.sh

# Install dependencies
./local-init.sh

# Run Ansible Playbook
ansible-playbook -i hosts.yaml mac_setup.yaml -l localhost -K
```

Run on remote workstations:

1. Update `hosts.yaml` with remote IP's, Usernames, and Passwords
2. Run Playbook:

 `ansible-playbook -i hosts.yaml mac_setup.yaml -l remotehosts`

## What's Installed

This installs the following packages
- Xcode
- Homebrew
- Python (version3.8)
- Pip
- Ansible
- Docker Desktop
- Python tools
  - black
  - flake8
  - pylint
  - sphinx
  - pytest
  - virtualenv
  - python-packaging
- Developer Tools
  - wget
  - tree
  - htop
  - iTerm2
  - VS Code
