# -------------------------------------------------------------------------------------------

Set-Alias -Name "l" -Value Get-ChildItem
Set-Alias -Name "note" -Value "C:\bin\Notepad++\notepad++.exe"

# -------------------------------------------------------------------------------------------
# posh-git
Import-Module posh-git

# プロンプトの上書き
function Prompt() {
    $pro = $pwd.ProviderPath
    Write-Host($pro) -nonewline
    Write-VcsStatus
    Write-Host("") # 改行
    return "> "
}

# []の中の色彩度を上げる
$GitPromptSettings.IndexForegroundColor = "Green"
$GitPromptSettings.WorkingForegroundColor = 'Red'
$GitPromptSettings.LocalWorkingStatusForegroundColor = 'Red'

# -------------------------------------------------------------------------------------------
