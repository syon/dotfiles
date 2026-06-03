{ pkgs, ... }:
{

  system.stateVersion = 7;
  nix.enable = false;

  environment.systemPackages = with pkgs; [
    git
  ];
  nixpkgs.hostPlatform = "aarch64-darwin";

  system.primaryUser = "syon";
  users.users.syon = {
    home = "/Users/syon";
    name = "syon";
  };

  networking.computerName = "M5MBA";
  networking.hostName = "M5MBA";

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      # ホットコーナー: 2=Mission Control, 10=Display Sleep
      wvous-tl-corner = 2;
      wvous-tr-corner = 10;
    };

    NSGlobalDomain = {
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      # F1、F2などのキーを標準のファンクションキーとして使用
      "com.apple.keyboard.fnState" = true;
    };

    trackpad = {
      # アクセシビリティ > 3本指のドラッグ
      TrackpadThreeFingerDrag = true;
    };
  };

  # nix-darwin に型付きオプションがない設定を defaults write / pmset で適用
  system.activationScripts.extraActivation.text = ''
    # 🌐キー: 2 = 絵文字と記号を表示 (ユーザー設定のため sudo -u で実行)
    sudo -u syon defaults write com.apple.HIToolbox AppleFnUsageType -int 2

    # .DS_Store をネットワークドライブ・USBドライブに作成しない
    sudo -u syon defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    sudo -u syon defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # ソフトウェアアップデート: macOSアップデートの自動インストールを無効化
    defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool false
    # システムデータファイルとセキュリティアップデートの自動インストールを無効化
    defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool false

    # バッテリー: 電源アダプタ接続時にディスプレイがオフでもスリープしない
    pmset -c sleep 0
  '';

  # 未対応: 以下の設定は手動またはカスタムスクリプトが必要
  # - Mission Control ショートカット (^[ / ^]) ... com.apple.symbolichotkeys の複雑なplist操作
  # - Spotlight ショートカット無効化 / アプリへの ⌘スペース 割り当て ... 同上
}
