function Clone-All {
    $RepoList = gh repo list $USERNAME --json nameWithOwner --limit 5000 | ConvertFrom-Json
    foreach ($repo in $RepoList) {
        gh repo clone $repo.nameWithOwner
    }
}

Clone-All