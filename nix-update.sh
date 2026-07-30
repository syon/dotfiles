#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOS'
Usage: nix-update.sh [options]

flake.lock を更新して nix-darwin を再適用します。
デフォルトでは nixpkgs-unstable input のみを更新するため、
stable 側 (nixpkgs / nix-darwin / home-manager) のバージョンは動きません。

Options:
  --all          全 input を更新する（stable 側のブランチ内で最新に追随）
  --no-rebuild   flake.lock の更新だけ行い、darwin-rebuild は実行しない
  -h, --help     このヘルプを表示
EOS
}

inputs=(nixpkgs-unstable)
rebuild=1

while (($#)); do
  case "$1" in
    --all) inputs=() ;;
    --no-rebuild) rebuild=0 ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      echo "不明なオプション: $1" >&2
      echo >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

# lock は chezmoi の source 側で更新する。
# 適用先 (~/.config/nix-darwin) を直接触っても次の chezmoi apply で巻き戻るため。
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ -d "$script_dir/dot_config/nix-darwin" ]]; then
  repo="$script_dir"
else
  repo="$(chezmoi source-path)"
fi
flake_dir="$repo/dot_config/nix-darwin"

# modules/ 内で pkgs-unstable.<name> として参照しているパッケージのバージョンを表示する。
# 現在の flake.lock が解決する値なので、実際に activate 済みかどうかとは独立。
unstable_versions() {
  local name version
  while read -r name; do
    version=$(
      nix eval --impure --raw --expr \
        "(builtins.getFlake \"path:$flake_dir\").inputs.nixpkgs-unstable.legacyPackages.\${builtins.currentSystem}.$name.version" \
        2>/dev/null
    ) || version="(取得失敗)"
    printf '  %-16s %s\n' "$name" "$version"
  done < <(grep -rhoE 'pkgs-unstable\.[a-zA-Z0-9_-]+' "$flake_dir/modules" | cut -d. -f2 | sort -u)
}

echo "==> 更新前"
unstable_versions

echo "==> nix flake update ${inputs[*]:-(全 input)}"
nix flake update "${inputs[@]}" --flake "$flake_dir"

echo "==> 更新後"
unstable_versions

if git -C "$repo" rev-parse --git-dir >/dev/null 2>&1 &&
  git -C "$repo" diff --quiet -- dot_config/nix-darwin/flake.lock; then
  echo "==> flake.lock に変更なし。すでに最新です"
  exit 0
fi

if ((rebuild)); then
  echo "==> $repo/darwin-rebuild.sh"
  "$repo/darwin-rebuild.sh"
fi

echo "==> flake.lock が更新されました。問題なければコミットしてください"
