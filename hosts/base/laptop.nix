{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./base.nix
      ../../nixosModules
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = ( with pkgs; [
    gnome-photos
    gnome-tour
    gnome-text-editor
    gnome-console
    epiphany
    yelp
    gnome-contacts
    simple-scan
    geary
    gnome-music
    gnome-characters
    gnome-maps
    totem
  ]);

  environment.sessionVariables.NIXOS_OZONE_WL="1";
  environment.sessionVariables.GOPATH="$HOME/.local/share/go";

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  virtualisation.containers.enable = true;
  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # So it shows up in the display manager?
  programs.sway.enable = true;

  # Install neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  security.polkit.enable = true;

  fonts.packages = with pkgs; [
    fira-code
    fira
    cooper-hewitt
    ibm-plex
    jetbrains-mono
    iosevka
    spleen
    fira-code-symbols
    powerline-fonts
    nerdfonts
    noto-fonts-color-emoji
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # web
    firefox

    # file management
    rclone

    # theme
    adw-gtk3

    # code
    go
    cargo
    rustc
    gcc
    python3
    git
    upx
    onefetch
    pkg-config
    lua
    openjdk

    # cli
    fish
    tlrc
    btop
    ripgrep
    fastfetch
    lsd
    wget
    fzf
    zoxide
    tmux

    # media
    mpv
    pulseaudio
    yt-dlp
    mediainfo
    jellyfin-media-player
    plex-media-player
    easyeffects
    komikku

    # misc
    networkmanagerapplet
    zip
    unzip
    jq
    nvtopPackages.amd
    ffmpeg
    openssl
    direnv
    virt-manager
    bat

    dive # look into docker image layers
    podman-tui # status of containers in the terminal
    podman-compose # start group of containers for dev

    distrobox
  ];

  programs.java.enable = true;

  haze.services = {
    syncthing.enable = true;
    tailscale.enable = true;
  };
}
