{ config, lib, pkgs, ... }: {
  options.haze = {
    apps = {
      foot = {
        enable = lib.mkEnableOption "foot - Terminal";
        font = lib.mkOption {
          type = lib.types.str;
          default = "JetBrainsMono Nerd Font:size=12";
          description = "Font name and size for foot terminal";
        };
      };
      fuzzel.enable = lib.mkEnableOption "Fuzzel - Launcher";
      waybar.enable = lib.mkEnableOption "Waybar - Wayland Bar";
      sioyek.enable = lib.mkEnableOption "Sioyek - PDF Reader";
      zathura.enable = lib.mkEnableOption "Zathura - Document Reader";
    };
    windowManager = {
      sway.enable = lib.mkEnableOption "Enable SwayWM";
    };
  };
}
