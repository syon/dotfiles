{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";

    brews = [
      "eza"
      "fzf"
      "sheldon"
      "starship"
    ];

    casks = [
      "1password"
      "arc"
      "brave-browser"
      "chrome-remote-desktop-host"
      "claude"
      "clipy"
      "discord"
      "dropbox"
      "github" # GitHub Desktop
      "google-chrome"
      "google-japanese-ime"
      "hammerspoon"
      "popclip"
      "visual-studio-code"
    ];

    masApps = {
      "LINE" = 539883307;
    };
  };
}
