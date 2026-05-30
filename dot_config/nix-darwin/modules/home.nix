{ pkgs, ... }:
{
  imports = [ ./fonts.nix ];

  home.stateVersion = "26.05";
  home.username = "syon";
  home.homeDirectory = "/Users/syon";

  home.packages = [ pkgs.chezmoi ];

  programs.git = {
    enable = true;
    ignores = [
      ".DS_Store"
      "**/.claude/settings.local.json"
    ];
  };
}
