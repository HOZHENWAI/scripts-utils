# Scripts that deals with code/repos and other.
All scripts come in 3 flavor:
- bash
- powershell

Some of them are configurable on call using env variable. i.e.
- ```VAR_NAME=value ./script_name.sh``` for linux 
- ```$env:VAR_NAME = "value"; ./script_name.ps1```
## Script list
- script that clones all repo from a user into the current directory (clone_all)
  - usage: 
    - ```USERNAME=github_username ./clone_all.sh``` for bash
  - requires:
    - ```gh``` installed and setup up (either token with correct permissions or authenticated)
- script that check all directories for forks of another project, update the forked branch to prepare for pull request locally
  - usage:
    - ``````
  - requires:
    - ```gh``` installed and setup
- script that install pre-commit hooks to all projects that are owned
  - usage:
    - ``````
  - requirements: 

# Installing the requirements:
- gh:
  - linux: [original documentation](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
  ```bash
  type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
  && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
  && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
  && sudo apt update \
  && sudo apt install gh -y
  ```
  - windows: install the binaries (see the [official gh documentation](https://github.com/cli/cli/) )