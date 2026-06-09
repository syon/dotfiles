{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "none";

    brews = [];

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
      "ghostty"
      "google-japanese-ime"
      "hammerspoon"
      "karabiner-elements"
      "obsidian"
      "popclip"
      "visual-studio-code"
    ];

    masApps = {
      "LINE" = 539883307;
    };
  };
}
