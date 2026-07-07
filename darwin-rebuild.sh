#!/usr/bin/env bash
set -euo pipefail

echo "==> chezmoi apply"
chezmoi apply

echo "==> sudo darwin-rebuild switch"
exec sudo darwin-rebuild switch --flake "$HOME/.config/nix-darwin"
