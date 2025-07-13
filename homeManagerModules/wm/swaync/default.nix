{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.haze.windowManager.swaync.enable {
    home.file = {
      ".config/swaync/config.json" = {
        source = ./config/config.json;
      };
      ".config/swaync/style.css" = {
        source = ./config/style.css;
      };
    };

    home.packages = [ pkgs.swaynotificationcenter ];
  };
}
