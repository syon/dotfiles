{ ... }:
{
  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "none";

    taps = [
      "manaflow-ai/cmux"
      "nikitabobko/tap"
      "penso/tap"
      "stablyai/orca"
    ];

    brews = [
      "awscli"
      "flyctl"
      # nixpkgs の mise は aarch64-darwin のバイナリキャッシュに無く、
      # 毎回ソースからのフルビルド（大量の rustc）になるため Homebrew から入れる。
      "mise"
    ];

    casks = [
      "1password"
      "1password-cli"
      "nikitabobko/tap/aerospace"
      "arc"
      "brave-browser"
      "chrome-remote-desktop-host"
      "claude"
      "clipy"
      "discord"
      "dropbox"
      "gcloud-cli"
      "github" # GitHub Desktop
      "google-chrome"
      "ghostty"
      "google-japanese-ime"
      "hammerspoon"
      "penso/tap/herdr-gpui"
      "karabiner-elements"
      "manaflow-ai/cmux/cmux"
      "obsidian"
      "orbstack"
      "popclip"
      "stablyai/orca/orca"
      "the-unarchiver"
      "visual-studio-code"
    ];

    masApps = {
      "LINE" = 539883307;
      "OneDrive" = 823766827;
    };
  };
}
