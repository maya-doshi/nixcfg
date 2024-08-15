{ config, lib, pkgs, ... }:

{
  options.maya.apps.fuzzel.enable = lib.mkEnableOption "Enable Fuzzel";

  config = lib.mkIf config.maya.apps.fuzzel.enable {
    programs.fuzzel = {
      enable = true;
      settings = {
        main = {
          terminal = "footclient";
          dpi-aware = "yes";
          show-actions = "yes";
        };
        colors = {
          background = "282828e6";
          text = "ebdbb2e6";
          match = "cc241de6";
          selection = "a89984e6";
          selection-text = "282828e6";
          border = "8ec07ce6";
        };
      };
    };
  };
}
