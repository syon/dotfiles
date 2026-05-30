{ pkgs, ... }:
{
  imports = [ ./fonts.nix ];

  home.stateVersion = "26.05";
  home.username = "syon";
  home.homeDirectory = "/Users/syon";

  programs.git.ignores = [
    ".DS_Store"
  ];
}
