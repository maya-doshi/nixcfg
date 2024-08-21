{ config, pkgs, ... }:

{
  imports = [
    ./laptop.nix
  ];

  haze.apps.foot.font = "JetBrainsMono Nerd Font:size=10";
}
