# madobe

madobe（窓辺） is dotfiles for windows.  

## Before Setup

### SSH setting of GitHub

```pwsh
$p = "~/.ssh/keys/github"
mkdir -p $p
ssh-keygen -t ed25519
Move-Item ~/.ssh/id_ed25519* $p/
Get-Content $p/id_ed25519.pub | clip
# paste pub-key to GitHub -> Settings -> SSH and GPG keys -> SSH keys
```

### Clone this repo

```pwsh
git clone git@github.com:guricerin/madobe.git
```

### enable running `.ps1` scripts

```pwsh
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

- Gitでクローンしたファイルはローカルスクリプトとして認識されるので、RemoteSignedで実行可能

### Install depends

```pwsh
.\path\to\madobe\scripts\depends.ps1
```

## Setup

### dry-run

```pwsh
.\path\to\madobe\setup.ps1
```

### apply

- enable developer mode (`System` -> `For developers` -> `Developer Mode` toggle on)

```pwsh
.\path\to\madobe\setup.ps1 -apply
```

## After Setup

### Install tools

```pwsh
.\path\to\madobe\scripts\tools.ps1
```

### Install bin from GitHub release page

- [gitleaks](https://github.com/gitleaks/gitleaks/releases)

## References

- [PowerShell実践ガイドブック クロスプラットフォーム対応の次世代シェルを徹底解説](https://book.mynavi.jp/ec/products/detail/id=90597)
