$path = "~/.ssh/keys/github"
mkdir -p $path
ssh-keygen -t ed25519
Move-Item ~/.ssh/id_ed25519* $path/
Get-Content $path/id_ed25519.pub | clip
