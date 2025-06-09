{ pkgs, lib, ... }:
{
  services.plex = {
    enable = true;
    dataDir = "/mnt/old/250GB/bonus/plex/";
    openFirewall = true;
  };
}
