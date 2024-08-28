{ config, pkgs, ... }:

{
  imports = [
    ./maya/laptop.nix
  ];

  home.packages = with pkgs; [
    steam
  ];
}
