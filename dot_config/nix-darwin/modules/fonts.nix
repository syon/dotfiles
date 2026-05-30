{ pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    geist-font
    lato
    plemoljp
    plemoljp-nf
    udev-gothic
    udev-gothic-nf
  ];
}
