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
    sheldon
    starship
    pkgs-unstable.uv
    whisper-cpp
    zoxide
  ];
}
