# Developer mode on Windows10 can avoid admin elevate issue.
#requires -version 7
Set-StrictMode -Version Latest

function AnswerIsYes($answer) {
  return $answer -eq "y"
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

function PrintSuccess($message) {
  Write-Host "  [o] $message" -ForegroundColor Green
}

function ReadLink($path) {
  return (Get-Item -LiteralPath $path).Target
}

Join-Path $PSScriptRoot "home" | Set-Variable -Name DOTFILES_HOME -Option Constant

function BuildSymlinkPath($path) {
  # e.g. C:\Users\user\dotfiles\home\.vimrc → C:\Users\user\.vimrc
  return $path.Replace($DOTFILES_HOME, $env:UserProfile)
}

function main() {
  Get-ChildItem -LiteralPath $DOTFILES_HOME -File -Force -Recurse |
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

if (!$IsWindows) {
  PrintError -message "Please run on Windows."
  exit 1
}

main
