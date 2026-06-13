{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chezmoi
    direnv
    eza
    bat
    fzf
    keifu
    ripgrep
    mise
    sheldon
    starship
    zoxide
  ];
}
