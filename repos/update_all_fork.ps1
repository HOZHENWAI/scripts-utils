$defaultUpstreamName = if($env:DEFAULT_UPSTREAM_NAME) {
    $env:DEFAULT_REMOTE_NAME
} else {
    "upstream"
}

$directoryPath = if($env:DIRECTORY_PATH) {
    $env:DIRECTORY_PATH
} else {
    "."
}

function Update-When-Is-Fork($dirPath) {
    Set-Location $dirPath

    # Check if the directory is a Git repository but checking .git hidden folder (this is not perfect)
    if (-not (Test-Path -Path .git -PathType Container)) {
        Write-Host "Skipped non git-repository folder: $repoPath"
        return
    }

    $repoInfo = gh repo view --json name,owner,defaultBranchRef,isFork --jq ".name, .owner.login, .defaultBranchRef.name, .isFork"
    $repoName = $repoInfo[0].ToString()
    $owner = $repoInfo[1].ToString()
    $defaultBranch = $repoInfo[2].ToString()
    $isFork = $repoInfo[3].ToBoolean()

    if ($isFork) {
        # Update the main branch of the fork
        gh repo sync -b $defaultBranch
        git push origin -u $defaultBranch
        Write-Host "Updated main branch (local and remote) $defaultBranch of forked repository: $repoName"
    } else
    {
        Write-Host "Skipped non-forked repository: $repoName"

    }
}