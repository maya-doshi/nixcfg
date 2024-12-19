{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../base/server.nix
      ./hardware-configuration.nix
    ];

  time.timeZone = "America/New_York";

  networking.hostName = "john"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maya = {
    isNormalUser = true;
    description = "maya";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}
