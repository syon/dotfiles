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

flake.lock を更新してから再適用します（`mise self-update` などパッケージ側の自己更新機能は使いません。バイナリが `/nix/store` にあるため失敗し、仮に通っても次の rebuild で巻き戻ります）。

これをまとめて行う [nix-update.sh](nix-update.sh) を用意しています。リポジトリ直下で以下を実行してください。

```sh
./nix-update.sh
```

`nixpkgs-unstable` input のみを更新し、更新前後で `pkgs-unstable.*` の各パッケージのバージョンを表示してから [darwin-rebuild.sh](darwin-rebuild.sh) を実行します。オプションは以下。

| オプション | 内容 |
| --- | --- |
| `--all` | 全 input を更新する（stable 側もブランチ内で最新に追随） |
| `--no-rebuild` | flake.lock の更新だけ行い、rebuild しない |

なお nixpkgs は stable チャンネル（26.05）を追っているため、パッケージのバージョンは基本的に固定です。更新の速いツール（uv など）だけ `nixpkgs-unstable` input から取得しています（[shell.nix](dot_config/nix-darwin/modules/shell.nix) の `pkgs-unstable.*` 参照）。

`nixpkgs-unstable` は Hydra のビルドが通ってからブランチが進むため、upstream のリリースから数日〜2 週間ほど遅れます。更新通知に出ているバージョンにすぐ追いつかないのは正常です。

### mise だけ Homebrew から入れている理由

nixpkgs の mise は **aarch64-darwin のバイナリキャッシュに存在しません**（`cache.nixos.org` に 404）。依存クレート数が多く `doCheck = true` なため、`darwin-rebuild` のたびに rustc がフルビルドを始めて非常に長く待たされます。stable / unstable どちらの input でも同じです。

Homebrew には arm64 の bottle が用意されており即座に入るので、mise は [homebrew.nix](dot_config/nix-darwin/modules/homebrew.nix) の `brews` で管理しています。`/opt/homebrew/bin` は nix のユーザープロファイルより PATH 上で優先されます。

トレードオフとして、mise のバージョンは flake.lock で固定されず常に最新へ追随します（`onActivation.autoUpdate = true` のため `darwin-rebuild` 時に更新されます）。mise は開発ツールであり後方互換の要求も緩いので、これは許容しています。

### 26.11 リリース時にやること

nixpkgs と nix-darwin はバージョンが一致していないとビルドが拒否されるため、[flake.nix](dot_config/nix-darwin/flake.nix) の 3 つの input のブランチを**同時に**上げます。

1. `nixpkgs.url` → `github:NixOS/nixpkgs/nixpkgs-26.11-darwin`
2. `nix-darwin.url` → `github:nix-darwin/nix-darwin/nix-darwin-26.11`
3. `home-manager.url` → `github:nix-community/home-manager/release-26.11`

その後 `./nix-update.sh --all` を実行してください。

`home.stateVersion` は「最新に追随すべきバージョン番号」ではなく後方互換の基準点マーカーなので、上げるのは任意です。上げる場合は Home Manager の release notes の **State Version Changes** を読んでから [home.nix](dot_config/nix-darwin/modules/home.nix) を書き換えます（release ブランチを上げるまでは enum で弾かれます）。

## cf.

- [2023年のシェル環境構築](https://zenn.dev/mizchi/scraps/8969fe29a27e21)
