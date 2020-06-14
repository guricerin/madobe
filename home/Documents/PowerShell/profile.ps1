# -------------------------------------------------------------------------------------------
# My-Util todo:baseパス指定
. "C:\Users\guriz\Documents\PowerShell\Scripts\My-Util.ps1"

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
# Get-ChildItemColor(色付きls)
Import-Module Get-ChildItemColor

# lsコマンドの動作をよりunix風に
Set-Alias ll Get-ChildItem -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# ファイル毎の表示色を明るめに変更
$GetChildItemColorTable.File['Directory'] = "Cyan"
foreach ($Exe in $GetChildItemColorExtensions.ExecutableList) {
    $GetChildItemColorTable.File[$Exe] = "Green"
}
foreach ($Src in $GetChildItemColorExtensions.SourceCodeList) {
    $GetChildItemColorTable.File[$Src] = "Green"
}

# -------------------------------------------------------------------------------------------