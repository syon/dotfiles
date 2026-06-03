# 新しい Mac のセットアップ

## 1. Nix をインストール

[Determinate Systems のインストーラー](https://github.com/DeterminateSystems/nix-installer) を使うのが確実です。

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

## 2. chezmoi で dotfiles を展開

`nix run` で chezmoi を一時実行し、このリポジトリから dotfiles を展開します。

```sh
nix run nixpkgs#chezmoi -- init --apply syon
```

`~/.config/nix-darwin` を含む全 dotfiles がホームディレクトリに配置されます。

## 3. nix-darwin を適用

```sh
sudo darwin-rebuild switch --flake ~/.config/nix-darwin
```

Homebrew・各種 CLI ツール・アプリが一括インストールされます。chezmoi 本体もここで Homebrew 管理下に入ります。
