{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "none";

    taps = [
      "manaflow-ai/cmux"
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
      "ghostty"
      "google-japanese-ime"
      "hammerspoon"
      "karabiner-elements"
      "manaflow-ai/cmux/cmux"
      "obsidian"
      "popclip"
      "visual-studio-code"
    ];

    masApps = {
      "LINE" = 539883307;
    };
  };
}
