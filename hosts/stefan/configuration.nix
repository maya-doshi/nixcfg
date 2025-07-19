{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./drives.nix
      ../base/server.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "stefan";

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.haze = {
    isNormalUser = true;
    description = "haze";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  haze.user = "haze";

  environment.systemPackages = with pkgs; [
  ];

  services = {
    plex = {
      enable = true;
      dataDir = "/mnt/old/250GB/bonus/appdata/plex/";
      openFirewall = true;
    };

    tautulli = {
      enable = true;
      dataDir = "/mnt/old/250GB/bonus/appdata/tautulli/";
      configFile = "/mnt/old/250GB/bonus/appdata/tautulli/config.ini";
      openFirewall = true;
      port = 8181;
    };

    kavita = {
      enable = true;
      dataDir = "/mnt/old/250GB/bonus/appdata/kavita/";
      tokenKeyFile = "/mnt/old/250GB/bonus/appdata/kavita/tokenKey";
      settings.Port = 5000;
    };

    navidrome = {
      enable = true;
      settings = {
        Address = "0.0.0.0";
        Port = 4533;
        EnableInsightsCollector = true;
        MusicFolder = "/mnt/old/4TB/4TB/Music/";
      };
      openFirewall = true;
      environmentFile = "/mnt/old/250GB/bonus/appdata/navidrome/env";
    };
  };

  haze.services = {
    memos = {
      enable = true;
      dataDir = "/mnt/old/250GB/bonus/appdata/memos/";
      openFirewall = true;
    };

    docker.enable = true;
    nextcloud.enable = true;
  };
}
