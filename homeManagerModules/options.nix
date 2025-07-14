{ config, lib, pkgs, ... }: {
  options.haze = {
    apps = {
      foot = {
        enable = lib.mkEnableOption "foot - Terminal";
        font = lib.mkOption {
          type = lib.types.str;
          default = "IosevkaTerm NF:size=7";
          description = "Font name and size for foot terminal";
        };
      };
      fuzzel.enable = lib.mkEnableOption "Fuzzel - Launcher";
      mpv.enable = lib.mkEnableOption "MPV - Media Player with scripts, cdda and sixel";
      sioyek.enable = lib.mkEnableOption "Sioyek - PDF Reader";
      zathura.enable = lib.mkEnableOption "Zathura - Document Reader";
    };
    windowManager = {
      sway.enable = lib.mkEnableOption "Enable SwayWM";
      i3blocks.enable = lib.mkEnableOption "Enable i3blocks";
      swaync.enable = lib.mkEnableOption "Enable SwayNC - Notification Center";
    };
    isDesktop = lib.mkEnableOption "are u using a desktop";
  };
}
