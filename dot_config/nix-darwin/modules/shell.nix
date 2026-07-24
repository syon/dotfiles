{ pkgs, pkgs-unstable, ... }:
{
  home.packages = with pkgs; [
    chezmoi
    direnv
    eza
    bat
    fzf
    keifu
    ripgrep
    pkgs-unstable.mise
    sheldon
    starship
    pkgs-unstable.uv
    whisper-cpp
    zoxide
  ];
}
