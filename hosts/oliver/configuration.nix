# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ../base/laptop.nix
      ./hardware-configuration.nix
    ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  time.timeZone = "America/Los_Angeles";

  networking.hostName = "oliver";

  programs.sway.extraOptions = [ "--unsupported-gpu" ];

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

  users.users.haze = {
    isNormalUser = true;
    description = "haze";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  haze.user = "haze";
}
