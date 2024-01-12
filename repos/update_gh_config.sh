#!/bin/bash

default_repo_name=${DEFAULT_REMOTE_NAME:-"origin"}
directory_path=${DIRECTORY_PATH:-"."}

get_owner_repo() {
  # Extract owner and repository name from remote URL
  owner_repo=$(echo "$1" | sed -n 's/.*[\/:]\([^\/:]\+\)\/\([^\/]\+\)\.git/\1\/\2/p')
  echo "$owner_repo"
}

update_default_repository() {
    dir_path=$1
    cd "$dir_path" || { echo "Failed to change directory to $dir_path"; exit 1; }

    # Check if the directory is a Git repository by checking .git hidden folder (this is not perfect)
    if [ ! -d .git ]; then
        echo "Skipped non git-repository folder: $dir_path"
        return
    fi

    # Get GitHub remote URL from git
    remote_url=$(git remote get-url "$default_repo_name")  # Assuming origin is the default remote
    remote_repo=$(get_owner_repo "$remote_url")
    gh repo set-default "$remote_repo"
}

for subfolder_path in "$directory_path"/*/; do
    update_default_repository "$subfolder_path"
done
