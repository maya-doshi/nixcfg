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
    sshfs
    waypipe
    rclone
    pass
    python3
    ffmpeg-full
    mediainfo
    picard
  ];

  programs.fuse.userAllowOther = true;

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
        MusicFolder = "/mnt/goliath/stor/Music";
      };
      openFirewall = true;
      environmentFile = "/mnt/old/250GB/bonus/appdata/navidrome/env";
    };

    miniflux = {
      enable = true;
      createDatabaseLocally = true;
      adminCredentialsFile = "/mnt/old/250GB/bonus/appdata/miniflux/admin-creds";
      config = {
        CLEANUP_FREQUENCY = 48;
        LISTEN_ADDR = "0.0.0.0:3245";
        METRICS_COLLECTOR=1;
        METRICS_ALLOWED_NETWORKS = "100.0.0.0/8";
      };
    };

    karakeep = {
      enable = true;
      browser.enable = true;
      browser.port = 9222;
      meilisearch.enable = true;
      extraEnvironment = {
        PORT = "9223";
        DISABLE_SIGNUPS = "true";
        DISABLE_NEW_RELEASE_CHECK = "true";
        DB_WAL_MODE = "true";
        ASSETS_DIR = "/mnt/old/250GB/bonus/appdata/karakeep/assets";

        CRAWLER_FULL_PAGE_ARCHIVE = "true";

        SMTP_SECURE = "true";

        OPENAI_BASE_URL = "https://generativelanguage.googleapis.com/v1beta";
        INFERENCE_TEXT_MODEL = "gemini-2.5-flash";
        INFERENCE_IMAGE_MODEL = "gemini-2.5-flash";
      };
      environmentFile = "/mnt/old/250GB/bonus/appdata/karakeep/secrets.env";
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

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };
}
