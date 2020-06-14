# dotfiles-win

## Usage

```posh
PS> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
PS> .\path\to\dotfiles-win\setup.ps1
```

## Tips

* Gitでクローンしたファイルはローカルスクリプトとして認識されるので、RemoteSignedで実行可能

## References

* [PowerShell実践ガイドブック クロスプラットフォーム対応の次世代シェルを徹底解説](https://book.mynavi.jp/ec/products/detail/id=90597)
