{ config, pkgs, ... }:

{
  imports =
  [
    ../base/laptop.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "logan";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maya = {
    isNormalUser = true;
    description = "maya";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

}
