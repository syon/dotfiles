{ pkgs, ... }:
{
  home.packages = with pkgs; [
    chezmoi
    direnv
    eza
    fzf
    keifu
    mise
    sheldon
    starship
    zoxide
  ];
}
