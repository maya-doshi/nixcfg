{ config, pkgs, ... }:

{
  imports =
  [
    ../base/laptop.nix
    ./hardware-configuration.nix
  ];

  # Set your time zone.
  time.timeZone = "Asia/Calcutta";

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "logan";

  zramSwap.enable = true;

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
