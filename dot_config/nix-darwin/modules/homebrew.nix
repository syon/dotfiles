{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";

    taps = [
      "trasta298/tap"
    ];

    brews = [
      "eza"
      "fzf"
      "keifu"
      "mise"
      "sheldon"
      "starship"
      "zoxide"
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
      "popclip"
      "visual-studio-code"
    ];

    masApps = {
      "LINE" = 539883307;
    };
  };
}
