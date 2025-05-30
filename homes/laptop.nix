{ config, pkgs, self, ... }:

{
  imports = [ ./base.nix ];

  home = {
    username = "maya";
    homeDirectory = "/home/maya";
  };
}
