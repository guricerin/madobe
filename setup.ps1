# Developer mode on Windows10 can avoid admin elevate issue.
#requires -version 7
Set-StrictMode -Version Latest

function AnswerIsYes($answer) {
    return $answer -eq "y"
}
function AskConfirmation($message) {
    PrintQuestion -message "$message (y/n) "
    $result = Read-Host
    return $result
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

function PrintQuestion($message) {
    Write-Host "  [?] $message" -ForegroundColor Yellow -NoNewline
}

function PrintSuccess($message) {
    Write-Host "  [o] $message" -ForegroundColor Green
}

function ReadLink($path) {
    return (Get-Item -LiteralPath $path).Target
}

Set-Variable -Name SCRIPT_ROOT -Value $PSScriptRoot -Option Constant

function MakeSymlinkPath($path) {
    return $path.Replace($SCRIPT_ROOT, $env:UserProfile)
}

function main() {
    $dotfiles_home = "${SCRIPT_ROOT}\home"

    Get-ChildItem -LiteralPath $dotfiles_home -File -Force -Recurse | 
    ForEach-Object {
        $sourceFile = $_.FullName
        $targetFile = MakeSymlinkPath -path $sourceFile
        $parent = Split-Path -Path $targetFile -Parent
        if (!(Test-Path -Path $parent)) {
            mkdir -Path "$parent" -Force > $null
        }
        if (Test-Path -Path $targetFile) {
            if ((ReadLink -path "$targetFile") -ne $sourceFile) {
                $answer = AskConfirmation -message "'$targetFile' already exists, do you want to overwrite it?"
                if (AnswerIsYes -answer $answer) {
                    Rename-Item -LiteralPath "$targetFile" -NewName "${targetFile}.bak" -Force > $null
                    New-Item -ItemType SymbolicLink -Path "$targetFile" -Value "$sourceFile" > $null
                    PrintResult -success $? -message "$targetFile → $sourceFile"
                }
                else {
                    PrintError -message "$targetFile → $sourceFile"
                }
            }
            else {
                PrintSuccess -message "$targetFile → $sourceFile"
            }
        }
        else {
            New-Item -ItemType SymbolicLink -Path "$targetFile" -Value "$sourceFile" > $null
            PrintResult -success $? -message "$targetFile → $sourceFile"
        }
    }
}

if (!$IsWindows) {
    PrintError -message "Please run on Windows."
    exit 1
}

main
