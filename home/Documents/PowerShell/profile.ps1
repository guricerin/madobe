# -------------------------------------------------------------------------------------------

Set-Alias -Name "l" -Value Get-ChildItem
Set-Alias -Name "ll" -Value Get-ChildItem
Set-Alias -Name "note" -Value "C:\bin\Notepad++\notepad++.exe"

function gs() {
    git status
}

# -------------------------------------------------------------------------------------------
# posh-git
Import-Module posh-git

# プロンプトの上書き
function Prompt() {
    Write-Host("[{0}@{1}] {2}" -f $env:UserName, $env:ComputerName, $pwd.ProviderPath) -nonewline
    Write-VcsStatus
    Write-Host("") # 改行
    return "> "
}

# []の中の色彩度を上げる
$GitPromptSettings.IndexForegroundColor = "Green"
$GitPromptSettings.WorkingForegroundColor = 'Red'
$GitPromptSettings.LocalWorkingStatusForegroundColor = 'Red'

# -------------------------------------------------------------------------------------------
