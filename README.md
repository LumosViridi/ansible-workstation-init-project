# Developer Workstation Setup
## Overview

This project uses Ansible - <https://www.ansible.com/> and Homebrew - <https://brew.sh/> to more easily configure a developers workstation.

This project assumes that XCode has been installed via the Apple App store and a user has authenticated to the device at least once.

This is only supported on MacOS Sonoma 14.5 or later and Apple Silicon M1 Chipset only. Believe me, I learned the hard way...

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

1. Update `hosts.yaml` with remote IP's or DNS names, Usernames, and Passwords or Private Keys.
2. Run Playbook:

 `ansible-playbook -i hosts.yaml mac_setup.yaml -l remotehosts`

## What's Installed

This installs the following packages
- Homebrew
- Python (version3.8)
- Pip
- Ansible
- Python tools
  - black (Code Formatter)
  - flake8 (Linter)
  - pylint (Code Analysis)
  - sphinx (Code Documentation)
  - pytest (Test Framework)
  - virtualenv (Python Virtual Environments)
  - python-packaging
- Developer Tools
  - wget (HTML Downloader)
  - tree (Lists current directory in tree format)
  - htop (User-friendly version of top)
  - gcc (GNU compiler collection)
  - Docker Desktop
  - iTerm2 (Alternative to default terminal)
  - VS Code (Common IDE)
