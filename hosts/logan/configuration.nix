{ config, pkgs, ... }:

{
  imports =
  [
    ../base/laptop.nix
    ./hardware-configuration.nix
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "logan";

  services.udev.packages = [ pkgs.dolphin-emu ];

  services.flatpak.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maya = {
    isNormalUser = true;
    description = "maya";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

}
