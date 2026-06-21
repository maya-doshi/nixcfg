{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./drives.nix
    ../base/server.nix
  ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "stefan";
    hostId = "bc0e4252";
    nftables.enable = true;
    firewall.trustedInterfaces = [ "incusbr0" ];
    firewall.allowedTCPPorts = [
      8443 # incus
      8765 # baikal
    ];
  };

  time.timeZone = "America/Los_Angeles";

  users = {
    groups = {
      media = {
        gid = 1000;
      };
      pine = {
        name = "pine";
        members = [ "pine" "haze" ];
      };
    };

    users = {
      haze = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "media" "incus-admin" ];
        packages = with pkgs; [];
      };
      pine = {
        isNormalUser = true;
        createHome = true;
        home = "/home/pine";
        useDefaultShell = true;
        uid = 1001;
        group = "pine";
        extraGroups = [ "media" ];

        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhRFxpA7Ik6Gy8wwPq3SJrRCRLIXubWbbgzTO4ea7TsOBHhEgpU0dqqNcm3ON6WKMbnmrGD54jYURR4qXg3sqlC+SViSKmgyRt0EJBUcprZBIOvUshMQVtODaDgPMMGTSQCqc2ALDuUGdCClYYMSmwGDi9Q97YjpWChSeBcfxlaQpwY8KaU6IF/G1uu0NtkTJWmNOxDqAKiAPjLlLAMGi/AdIfNCmeACionYPVRI2mjaF9L+tUxW60I4cO3YiGAaum6lM4bJuVZtEqvBz0IQj2FFgUwyEsLwYrkfHR0f6q8X2hG/Zg6d6TTvmBIBnemofxypm7xc6R0jCJDoEE9OlUTpvltYiSRrizJdGsJJOLGBvhd6eAkPxjt5cVwEnr1R+svykyol6UorSB/w8T1w8u8dAwB28kxy4V2stZH1uo+kaF3bH57+8T3mkXJxC00BBfH077Mql1tgoR9gfh2r42U45AjHfUjuvfVISDUI46wlptrlgKnIug0kl5TJ0ESCE= pine@venus"
        ];
      };
    };
  };

  haze.user = "haze";

  environment.systemPackages = with pkgs; [
    pass
    ffmpeg-full
    mediainfo
    picard
  ];

  virtualisation = {
    podman.enable = true;

    incus = {
      enable = true;
      ui.enable = true;
    };
  };

  services = {
    plex = {
      enable = true;
      group = "media";
      openFirewall = true;
    };

    tautulli = {
      enable = true;
      dataDir = "/var/lib/tautulli/";
      configFile = "/var/lib/tautulli/config.ini";
      openFirewall = true;
      port = 8181;
    };

    navidrome = {
      enable = true;
      settings = {
        Address = "100.125.122.35";
        Port = 4533;
        EnableInsightsCollector = true;
        MusicFolder = "/mnt/elena/media/music";
      };
      group = "media";
      openFirewall = true;
      environmentFile = "/var/lib/navidrome/env";
      plugins = with pkgs.navidromePlugins; [
        apple-music
        listenbrainz-daily-playlist
      ];
    };

    miniflux = {
      enable = true;
      createDatabaseLocally = true;
      adminCredentialsFile = "/var/lib/miniflux/admin-creds";
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
        ASSETS_DIR = "/var/lib/karakeep/assets";

        CRAWLER_FULL_PAGE_ARCHIVE = "true";
        CRAWLER_ENABLE_ADBLOCKER = "true";
        CRAWLER_VIDEO_DOWNLOAD = "true";
        CRAWLER_VIDEO_DOWNLOAD_MAX_SIZE= "-1";

        SMTP_SECURE = "false";

        INFERENCE_ENABLE_AUTO_SUMMARIZATION = "false";

        OPENAI_BASE_URL = "https://generativelanguage.googleapis.com/v1beta";
        INFERENCE_TEXT_MODEL = "gemini-2.5-flash-lite";
        INFERENCE_IMAGE_MODEL = "gemini-2.5-flash";
        INFERENCE_CONTEXT_LENGTH = "16384";
        INFERENCE_MAX_OUTPUT_TOKENS = "16384";
        INFERENCE_JOB_TIMEOUT_SEC = "60";
      };
      environmentFile = "/var/lib/karakeep/secrets.env";
    };

    n8n = {
      enable = true;
      openFirewall = true;
      environment.N8N_SECURE_COOKIE = "false";
    };

    baikal = {
      enable = true;
      virtualHost = "cd.k4x.club";
    };

    nginx.virtualHosts."cd.k4x.club".listen = [ { addr = "100.125.122.35"; port = 8765; } ]; # tailscale ip of stefan
  };

  haze.services = {
    memos = {
      enable = true;
      openFirewall = true;
    };

    docker.enable = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };
}
