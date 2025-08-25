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
  users.users = {
    haze = {
      isNormalUser = true;
      description = "haze";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [];
    };
    pine = {
      isNormalUser = true;
      description = "0xcad";
      home = "/mnt/goliath/stor/0xcad";
      openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhRFxpA7Ik6Gy8wwPq3SJrRCRLIXubWbbgzTO4ea7TsOBHhEgpU0dqqNcm3ON6WKMbnmrGD54jYURR4qXg3sqlC+SViSKmgyRt0EJBUcprZBIOvUshMQVtODaDgPMMGTSQCqc2ALDuUGdCClYYMSmwGDi9Q97YjpWChSeBcfxlaQpwY8KaU6IF/G1uu0NtkTJWmNOxDqAKiAPjLlLAMGi/AdIfNCmeACionYPVRI2mjaF9L+tUxW60I4cO3YiGAaum6lM4bJuVZtEqvBz0IQj2FFgUwyEsLwYrkfHR0f6q8X2hG/Zg6d6TTvmBIBnemofxypm7xc6R0jCJDoEE9OlUTpvltYiSRrizJdGsJJOLGBvhd6eAkPxjt5cVwEnr1R+svykyol6UorSB/w8T1w8u8dAwB28kxy4V2stZH1uo+kaF3bH57+8T3mkXJxC00BBfH077Mql1tgoR9gfh2r42U45AjHfUjuvfVISDUI46wlptrlgKnIug0kl5TJ0ESCE= pine@venus" ];
    };
  };
  haze.user = "haze";

  environment.systemPackages = with pkgs; [
    gnome-keyring
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
