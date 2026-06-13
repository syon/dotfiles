{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chezmoi
    direnv
    eza
    fzf
    keifu
    ripgrep
    mise
    sheldon
    starship
    zoxide
  ];
}
