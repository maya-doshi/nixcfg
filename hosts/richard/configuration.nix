{ config, pkgs, ... }:

{
  imports =
  [
    ../base/laptop.nix
    ./hardware-configuration.nix
  ];

  time.timeZone = "America/Los_Angeles";

  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "richard";

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  users.users.maya = {
    isNormalUser = true;
    description = "maya";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };
  haze.user = "maya";
}
