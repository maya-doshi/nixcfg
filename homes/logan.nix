{ config, pkgs, ... }:

{
  imports = [ ./maya/laptop.nix ];

  home.packages = with pkgs; [
    # Handwriting
    xournalpp

    # Dev
    vscode
    zed-editor

    # misc
    ryzenadj
    ryzen-monitor-ng
    hexchat
    obs-studio
  ];
}
