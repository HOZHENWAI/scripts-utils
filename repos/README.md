# Scripts that deals with code/repos and other. (works only with github)
All scripts come in 3 flavor:
- bash
- powershell

Some of them are configurable on call using env variable. i.e.
- ```VAR_NAME=value ./script_name.sh``` for linux 
- ```$env:VAR_NAME = "value"; ./script_name.ps1```
## Script list
- script that clones all repo from a user into the current directory (clone_all), note that since that the default parent repository for a fork is its parent repository.
  - usage: 
    - ```USERNAME=github_username ./clone_all.sh``` for bash
  - requires:
    - ```gh``` installed and setup up (either token with correct permissions or authenticated)
  - note:
    - using `gh` to clone the project will setup the default repository to the upstream which, in the case where the fork has significantly diverged from its source, may not be the one we want
- script that, for all git directories, update the gh default repository to its forked value (given by user) and for non fork project that were not setup with gh, setup the gh default remote repository (using git remote/default is `origin`)
  - usage:
    - ```DEFAULT_REMOTE_NAME=origin DIRECTORY_PATH="." ./update_all_fork.sh```
  - requires:
    - `git` and `gh` installed
  - case taken into account:
    - directory is not a git repository
    - directory is a non forked clone of a public repository
      - will set the `gh default repository` if not already existing (if you want to fork the repo later, you will have to replace the default and/or remote as needed)
    - directory is a clone of an owned private/public repository
      - will set the `gh default repository` if not already existing
    - directory is a clone of a forked public/repository (either with `git clone` or `gh repo clone`)
      - if `gh` was used to clone, there are two remote: the `origin` and the `upstream`, with the default repository set to the upstream
      - if `git` was used to clone, there is only one remote: the `origin`, with no default repository


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