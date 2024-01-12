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
    $OwnerRepo = $remoteUrl -replace '.*[\/:]([^\/:]+)\/([^\/]+)\.git', '$1/$2'

    return $OwnerRepo
}

function Update-Default-Repository($dirPath) {
    Set-Location $dirPath

    # Check if the directory is a Git repository by checking .git hidden folder (this is not perfect)
    if (-not (Test-Path -Path .git -PathType Container)) {
        Write-Host "Skipped non git-repository folder: $repoPath"
        return
    }

    # Get github remote url from git
    $remote_url = git remote get-url $defaultRemoteName
    $remoteRepo = Get-OwnerRepo $remote_url
    gh repo set-default $remoteRepo
}

Get-ChildItem -Path $directoryPath -Directory | ForEach-Object {
    $subfolderPath = $_.FullName
    Update-Default-Repository $subfolderPath
}