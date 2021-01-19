# -------------------------------------------------------------------------------------------
## alias

# ls
Set-Alias -Name "l" -Value Get-ChildItem
Set-Alias -Name "ll" -Value Get-ChildItem
Set-Alias -Name "note" -Value "C:\bin\Notepad++\notepad++.exe"
# docker
Set-Alias -Name "dc" -Value docker
Set-Alias -Name "dcc" -Value docker-compose
function Docker-Exec() {
    docker exec -it $args
}
Set-Alias -Name "dce" -Value Docker-Exec

function gs() {
    git status
}

# -------------------------------------------------------------------------------------------
## posh-git
Import-Module posh-git

$GitPromptSettings.DefaultPromptPrefix = "[${env:UserName}@${env:ComputerName}] "
$GitPromptSettings.DefaultPromptSuffix = "`n> "

# -------------------------------------------------------------------------------------------
