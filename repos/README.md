# Scripts that deals with code/repos and other.
All scripts come in 3 flavor:
- bash
- python
- powershell

Some of them are configurable on call using env variable. i.e.
- ```VAR_NAME=value ./script_name.sh``` for linux 
- ```$env:VAR_NAME = "value"; ./script_name.ps1```
- ```VAR_NAME=value python script_name.py``` or similar for powershell
## Script list
- script that clones all repo from a user into the current directory (clone_all)
  - usage: 
    - ```USERNAME=github_username ./clone_all.sh``` for bash
  - requires:
    - ```gh``` installed
- script that check all directories for forks of another project, update the forked branch to prepare for pull request locally
  - usage:
    - ``````
  - requires:
    - ```gh``` installed and setup
- script that install pre-commit hooks to all projects that are owned
  - usage:
    - ``````
  - requirements:
