@(
  "GitHub.cli"
) | ForEach-Object {
  Write-Host "Installing $_"
  winget install -e --id $_
}

@(
  "ghq"
) | ForEach-Object {
  Write-Host "Installing $_"
  scoop install $_
}
