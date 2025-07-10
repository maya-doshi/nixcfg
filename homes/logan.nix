{ config, pkgs, ... }:

{
  imports = [ ./laptop.nix ];

  home.packages = with pkgs; [
    # CAD
    kicad

    # Handwriting
    xournalpp

    # Dev
    vscode
    zed-editor

    # misc
    ryzenadj
    ryzen-monitor-ng
    obs-studio
  ];

  wayland.windowManager.sway.config.output = {
    "eDP-1" = {
      mode = "2880x1800@90.001Hz";
      pos = "2560 0";
      transform = "normal";
      scale = "1.50";
      adaptive_sync = "off";
      dpms = "on";
    };
    "DP-1" = {
      mode = "3840x2160@60.0Hz";
      pos = "0 0";
      transform = "normal";
      scale = "1.50";
      adaptive_sync = "off";
      dpms = "on";
    };
    "DP-2" = {
      mode = "3840x2160@60.0Hz";
      pos = "0 0";
      transform = "normal";
      scale = "1.50";
      adaptive_sync = "off";
      dpms = "on";
    };
  };
}
