{ config, pkgs, self, ... }:
{
  home.stateVersion = "25.11";

  imports = [
    ../homeManagerModules
  ];

  haze.apps = {
    sioyek.enable = true;
    zathura.enable = true;
    foot.enable = true;
    mpv.enable = true;
    fuzzel.enable = true;
  };

  haze.windowManager.sway.enable = true;

  home.file = {};

  home.sessionVariables = {};

  programs = {
    home-manager.enable = true; # Let Home Manager install and manage itself.
  };
}
