# madobe

## Requirements

- sudo

```pwsh
$ scoop install sudo
```

## Usage

### before running script

```posh
PS> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
```

- Gitでクローンしたファイルはローカルスクリプトとして認識されるので、RemoteSignedで実行可能

### dry-run

```posh
PS> .\path\to\madobe\setup.ps1
```

### apply

```posh
PS> sudo .\path\to\madobe\setup.ps1 -apply
```

## References

- [PowerShell実践ガイドブック クロスプラットフォーム対応の次世代シェルを徹底解説](https://book.mynavi.jp/ec/products/detail/id=90597)
