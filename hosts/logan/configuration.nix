{ config, pkgs, ... }:

{
  imports =
  [
    ../base/laptop.nix
    ./hardware-configuration.nix
  ];

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages;
  boot.supportedFilesystems = [ "zfs" ];

  networking.hostName = "logan";
  networking.hostId = "3cebc3c4";

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  haze.gaming = {
    steam.enable = true;
    emu.dolphin = {
      enable = true;
      gc-oc = true;
    };
  };

  services = {
    flatpak.enable = true;
    openssh.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maya = {
    isNormalUser = true;
    description = "maya";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
  };

}
