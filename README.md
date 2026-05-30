# syon/dotfiles

## 🏠 chezmoi

`dot_` プレフィックスが付いたファイル・ディレクトリは [chezmoi](https://www.chezmoi.io/) によって管理されています。`chezmoi apply` を実行することでホームディレクトリに展開されます。逆に、ホームディレクトリ上のファイルを編集した後は `chezmoi re-add` を実行することでその変更をこのリポジトリに反映できます。

## ❄️ nix-darwin

[nix-darwin](dot_config/nix-darwin/) は macOS のシステム設定を Nix で宣言的に管理するための設定です。[home-manager](https://github.com/nix-community/home-manager) を組み合わせてユーザー環境も管理しています。

設定を適用するには以下を実行します。

```sh
sudo darwin-rebuild switch --flake ~/.config/nix-darwin
```

## cf.

- [2023年のシェル環境構築](https://zenn.dev/mizchi/scraps/8969fe29a27e21)
