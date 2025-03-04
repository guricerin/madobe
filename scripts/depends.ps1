@(
  "Microsoft.PowerShell" # PowerShell Core
  "Git.Git"
) | ForEach-Object {
  Write-Host "Installing $_"
  winget install -e --id $_
}
