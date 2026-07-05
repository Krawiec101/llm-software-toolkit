param(
    [string]$RepoUrl = $(if ($env:LLM_TOOLKIT_REPO_URL) { $env:LLM_TOOLKIT_REPO_URL } else { "https://github.com/Krawiec101/llm-software-toolkit.git" }),
    [string]$Ref = $(if ($env:LLM_TOOLKIT_REF) { $env:LLM_TOOLKIT_REF } else { "main" }),
    [string]$CacheDir = $(if ($env:LLM_TOOLKIT_CACHE_DIR) { $env:LLM_TOOLKIT_CACHE_DIR } elseif ($env:LOCALAPPDATA) { Join-Path $env:LOCALAPPDATA "llm-software-toolkit\source" } else { Join-Path $HOME ".cache/llm-software-toolkit/source" })
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$ToolkitHome = ".llm-toolkit"
$ManagedDir = "toolkit"
$ManifestName = "manifest.json"
$CopyItems = @(
    "README.md",
    "CHANGELOG.md",
    "install.ps1",
    "install.sh",
    "docs",
    "adapters",
    "workflows",
    "skills"
)

function Invoke-Checked {
    param(
        [string]$Command,
        [string[]]$Arguments
    )

    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed: $Command $($Arguments -join ' ')"
    }
}

function Get-UtcTimestamp {
    return (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
}

function Assert-ChildPath {
    param(
        [string]$Path,
        [string]$Parent
    )

    $trimChars = @([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
    $fullPath = [System.IO.Path]::GetFullPath($Path)
    $fullParent = [System.IO.Path]::GetFullPath($Parent).TrimEnd($trimChars)
    $prefix = $fullParent + [System.IO.Path]::DirectorySeparatorChar

    if (-not $fullPath.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Refusing unsafe path outside target project: $fullPath"
    }
}

function Get-InstalledAt {
    param(
        [string]$ManifestPath,
        [string]$DefaultValue
    )

    if (-not (Test-Path $ManifestPath)) {
        return $DefaultValue
    }

    try {
        $manifest = Get-Content -Raw -LiteralPath $ManifestPath | ConvertFrom-Json
        if ($manifest.installed_at) {
            return [string]$manifest.installed_at
        }
    }
    catch {
        return $DefaultValue
    }

    return $DefaultValue
}

function Sync-Toolkit {
    param(
        [string]$SourceDir,
        [string]$ProjectDir
    )

    $homeDir = Join-Path $ProjectDir $ToolkitHome
    $managed = Join-Path $homeDir $ManagedDir
    $tmp = Join-Path $homeDir "$ManagedDir.tmp"

    Assert-ChildPath $managed $ProjectDir
    Assert-ChildPath $tmp $ProjectDir
    New-Item -ItemType Directory -Force -Path $homeDir | Out-Null

    if (Test-Path $tmp) {
        Remove-Item -LiteralPath $tmp -Recurse -Force
    }
    New-Item -ItemType Directory -Force -Path $tmp | Out-Null

    try {
        foreach ($item in $CopyItems) {
            $sourceItem = Join-Path $SourceDir $item
            $targetItem = Join-Path $tmp $item
            if (-not (Test-Path $sourceItem)) {
                throw "Required source item is missing: $sourceItem"
            }
            Copy-Item -LiteralPath $sourceItem -Destination $targetItem -Recurse -Force
        }

        if (Test-Path $managed) {
            Remove-Item -LiteralPath $managed -Recurse -Force
        }
        Move-Item -LiteralPath $tmp -Destination $managed
    }
    catch {
        if (Test-Path $tmp) {
            Remove-Item -LiteralPath $tmp -Recurse -Force
        }
        throw
    }
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git was not found. Install Git and rerun this installer."
}

$projectDir = (Get-Location).Path
$sourceDir = [System.IO.Path]::GetFullPath($CacheDir)
$sourceGit = Join-Path $sourceDir ".git"

if (Test-Path $sourceGit) {
    Invoke-Checked "git" @("-C", $sourceDir, "remote", "set-url", "origin", $RepoUrl)
    Invoke-Checked "git" @("-C", $sourceDir, "fetch", "--tags", "origin")
    Invoke-Checked "git" @("-C", $sourceDir, "checkout", $Ref)
    $branch = (& git -C $sourceDir rev-parse --abbrev-ref HEAD).Trim()
    if ($LASTEXITCODE -ne 0) {
        throw "Could not inspect cached toolkit branch."
    }
    if ($branch -ne "HEAD") {
        Invoke-Checked "git" @("-C", $sourceDir, "pull", "--ff-only", "origin", $branch)
    }
}
elseif (Test-Path $sourceDir) {
    throw "Cache path exists but is not a git repository: $sourceDir"
}
else {
    $parent = Split-Path -Parent $sourceDir
    New-Item -ItemType Directory -Force -Path $parent | Out-Null
    Invoke-Checked "git" @("clone", $RepoUrl, $sourceDir)
    Invoke-Checked "git" @("-C", $sourceDir, "checkout", $Ref)
}

$now = Get-UtcTimestamp
$manifestPath = Join-Path (Join-Path $projectDir $ToolkitHome) $ManifestName
$installedAt = Get-InstalledAt $manifestPath $now
$sourceCommit = (& git -C $sourceDir rev-parse HEAD).Trim()
if ($LASTEXITCODE -ne 0) {
    throw "Could not inspect toolkit commit."
}

Sync-Toolkit $sourceDir $projectDir

$manifest = [ordered]@{
    schema_version = 1
    mode = "git-bootstrap"
    source_remote = $RepoUrl
    source_ref = $Ref
    source_commit = $sourceCommit
    managed_path = "$ToolkitHome/$ManagedDir"
    installed_at = $installedAt
    updated_at = $now
    copy_items = $CopyItems
}

$manifestDir = Split-Path -Parent $manifestPath
New-Item -ItemType Directory -Force -Path $manifestDir | Out-Null
$manifest | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $manifestPath -Encoding UTF8

Write-Host "Installed toolkit into $(Join-Path (Join-Path $projectDir $ToolkitHome) $ManagedDir)"
Write-Host "Manifest: $manifestPath"
Write-Host "Toolkit source: $sourceDir"
Write-Host "Toolkit ref: $Ref"
