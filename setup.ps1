# Developer mode on Windows10 can avoid admin elevate issue.
#requires -version 7
Param(
  [switch]$apply = $false
)
Set-StrictMode -Version Latest

function IsDeveloperMode() {
  $res = $(Get-ItemPropertyValue registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense)
  return $res -eq 1
}

function PrintResult([bool]$success, $message) {
  if ($success) {
    PrintSuccess -message $message
  }
  else {
    PrintError -message $message
    exit 1
  }
}

function PrintError($message) {
  Write-Host "  [x] $message" -ForegroundColor Red
}

function PrintWarn($message) {
  Write-Host "  [!] $message" -ForegroundColor Yellow
}

function PrintSuccess($message) {
  Write-Host "  [o] $message" -ForegroundColor Green
}

function PrintExpected($message) {
  Write-Host "  [?] $message" -ForegroundColor Blue
}

Join-Path $PSScriptRoot "home" | Set-Variable -Name DOTFILES_HOME -Option Constant

function DotFilePaths() {
  return Get-ChildItem -LiteralPath $DOTFILES_HOME -File -Force -Recurse
}

function BuildSymlinkPath($path) {
  # e.g. C:\Users\user\madobe\home\.vimrc → C:\Users\user\.vimrc
  return $path.Replace($DOTFILES_HOME, $env:UserProfile)
}

function Apply() {
  DotFilePaths |
  ForEach-Object {
    $src = $_.FullName
    $dst = BuildSymlinkPath -path $src
    $parent = Split-Path -Path $dst -Parent
    if (!(Test-Path -Path $parent)) {
      mkdir -Path "$parent" -Force > $null
    }
    if (Test-Path -Path $dst) {
      Remove-Item -LiteralPath $dst -Force > $null
    }
    New-Item -ItemType SymbolicLink -Path "$dst" -Value "$src" > $null
    PrintResult -success $? -message "$dst -> $src"
  }
}

function DryRun() {
  DotFilePaths |
  ForEach-Object {
    $src = $_.FullName
    $dst = BuildSymlinkPath -path $src
    PrintExpected -message "$dst -> $src"
  }
}

function Main() {
  if (!$IsWindows) {
    PrintError -message "Please run on Windows."
    exit 1
  }

  $isDevMode = IsDeveloperMode
  if ($apply) {
    if (!$isDevMode) {
      PrintError -message "Required developer mode to build symlink."
      exit 1
    }

    Write-Host "apply`n"
    Apply
  }
  else {
    Write-Host "dry-run`n"

    if (!$isDevMode) {
      PrintWarn -message "Required developer mode to build symlink."
    }

    DryRun
  }
}

Main
