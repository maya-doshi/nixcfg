{ config, pkgs, ... }:

{
  imports = [ ./maya/laptop.nix ];

  home.packages = with pkgs; [
    # Handwriting
    xournalpp
    rnote

    # Dev
    vscode
    nodejs_22
  ];
}
