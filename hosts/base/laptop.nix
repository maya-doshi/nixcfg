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

  # services.xserver.displayManager.gdm.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember-session";
        user = "greeter";
      };
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL="1";
  environment.sessionVariables.GOPATH="$HOME/.local/share/go";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # So it shows up in the display manager?
  programs = {
    sway.enable = true;
    niri.enable = true;
  };

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
    nerd-fonts.jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.open-dyslexic
    nerd-fonts.atkynson-mono
    nerd-fonts.bigblue-terminal
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
    cargo
    python3
    git
    onefetch

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
    pulseaudio
    yt-dlp
    mediainfo
    easyeffects

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
    dive # look into docker image layers
    sshfs

    # gnome stuff
    glib
    snapshot
    gnome-calendar
    gnome-clocks
    nautilus
    file-roller
    gnome-calculator
    gnome-online-accounts
    gnome-online-accounts-gtk
    gnome-connections
    gnome-keyring
    loupe
    adwaita-icon-theme
    adwaita-icon-theme-legacy
  ];

  haze.devices.qudelix5k.enable = true;

  haze.services = {
    emacs.enable = true;
    syncthing.enable = true;
    tailscale.enable = true;
  };
}
