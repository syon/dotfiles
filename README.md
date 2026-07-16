# syon/dotfiles

## 💻 新しい Mac のセットアップ

[SETUP.md](SETUP.md) を参照してください。

## 🏠 chezmoi

`dot_` プレフィックスが付いたファイル・ディレクトリは [chezmoi](https://www.chezmoi.io/) によって管理されています。`chezmoi apply` を実行することでホームディレクトリに展開されます。逆に、ホームディレクトリ上のファイルを編集した後は `chezmoi re-add` を実行することでその変更をこのリポジトリに反映できます。

## ❄️ nix-darwin

[nix-darwin](dot_config/nix-darwin/) は macOS のシステム設定を Nix で宣言的に管理するための設定です。[home-manager](https://github.com/nix-community/home-manager) を組み合わせてユーザー環境も管理しています。

設定を適用するには `chezmoi apply` を実行してから `darwin-rebuild switch` する必要がありますが、これをまとめて行う [darwin-rebuild.sh](darwin-rebuild.sh) を用意しています。リポジトリ直下で以下を実行してください。

```sh
./darwin-rebuild.sh
```

### パッケージのアップデート

flake.lock を更新してから再適用します（`mise self-update` などパッケージ側の自己更新機能は使いません）。

```sh
nix flake update --flake dot_config/nix-darwin
./darwin-rebuild.sh
```

なお nixpkgs は stable チャンネル（26.05）を追っているため、パッケージのバージョンは基本的に固定です。更新の速いツール（mise など）だけ `nixpkgs-unstable` input から取得しています（[shell.nix](dot_config/nix-darwin/modules/shell.nix) の `pkgs-unstable.*` 参照）。

### 26.11 リリース時にやること

nixpkgs と nix-darwin はバージョンが一致していないとビルドが拒否されるため、[flake.nix](dot_config/nix-darwin/flake.nix) の 3 つの input のブランチを**同時に**上げます。

1. `nixpkgs.url` → `github:NixOS/nixpkgs/nixpkgs-26.11-darwin`
2. `nix-darwin.url` → `github:nix-darwin/nix-darwin/nix-darwin-26.11`
3. `home-manager.url` → `github:nix-community/home-manager/release-26.11`

その後 `nix flake update --flake dot_config/nix-darwin` して `./darwin-rebuild.sh` を実行してください。

## cf.

- [2023年のシェル環境構築](https://zenn.dev/mizchi/scraps/8969fe29a27e21)
