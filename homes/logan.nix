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
}
