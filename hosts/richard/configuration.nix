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

  networking.hostName = "richard";

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  services = {
    openssh.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maya = {
    isNormalUser = true;
    description = "maya";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };
  haze.user = "maya";

}
