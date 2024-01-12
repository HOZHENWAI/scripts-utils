$defaultUpstreamName = if($env:DEFAULT_UPSTREAM_NAME) {
    $env:DEFAULT_REMOTE_NAME
} else {
    "upstream"
}

$defaultRemoteName = if($env:DEFAULT_REMOTE_NAME) {
    $env:DEFAULT_REMOTE_NAME
} else {
    "origin"
}

$directoryPath = if($env:DIRECTORY_PATH) {
    $env:DIRECTORY_PATH
} else {
    "."
}

function Get-OwnerRepo($remoteUrl) {

    # Extract owner and repository name from remote URL
    $ownerRepo = $remoteUrl -replace '.*[\/:]([^\/:]+)\/([^\/]+)\.git', '$1/$2'
    return $ownerRepo
}


function Update-WhenIsFork($dirPath) {
    Set-Location $dirPath

    # Check if the directory is a Git repository but checking .git hidden folder (this is not perfect)
    if (-not (Test-Path -Path .git -PathType Container)) {
        Write-Host "Skipped non git-repository folder: $repoPath"
        return
    }

    $repoInfo = gh repo view --json name,defaultBranchRef,isFork --jq ".name, .defaultBranchRef.name, .isFork"
    $repoName = $repoInfo[0]
    $defaultBranch = $repoInfo[1]
    $isFork = [System.Convert]::ToBoolean($repoInfo[2])

    if ($isFork) {
        # get the upstream repo name
        $upstreamUrl = git remote get-url $defaultUpstreamName
        $ownerRepo = Get-OwnerRepo $upstreamUrl

        gh repo sync -b $defaultBranch -s $ownerRepo
        git push $defaultRemoteName -u $defaultBranch
        Write-Host "Updated main branch (local and remote) $defaultBranch of forked repository: $repoName"
    } else
    {
        Write-Host "Skipped non-forked repository: $repoName"
    }
}

Get-ChildItem -Path $directoryPath -Directory | ForEach-Object {
    $subfolderPath = $_.FullName
    Update-WhenIsFork $subfolderPath
}
