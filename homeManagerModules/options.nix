{ config, lib, pkgs, ... }: {
  options.maya = {
    apps = {
      foot.enable = lib.mkEnableOption "foot - Terminal";
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
