{ config, pkgs, ... }:

{
  imports =
  [
    ../base/laptop.nix
    ./hardware-configuration.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "America/Los_Angeles";

  networking.hostName = "logan";
  networking.hostId = "3cebc3c4";

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  haze.gaming = {
    steam.enable = true;
    emu.dolphin = {
      enable = true;
      gc-oc = true;
    };
  };

  users.users.maya = {
    isNormalUser = true;
    description = "maya";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
  };
  haze.user = "maya";
}
