{ config, pkgs, ... }:

{
  imports =
    [
      ./base.nix
      ../../nixosModules
    ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  services.xserver.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions --remember-session";
        user = "greeter";
      };
    };
  };

  services.gvfs.enable = true;

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
  };

  services.upower.enable = true;

  security.rtkit.enable = true;

  virtualisation = {
    containers.enable = true;
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };

  # So it shows up in the display manager?
  programs = {
    sway.enable = true;
  };

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  security.polkit.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL="1";
    GOPATH="$HOME/.local/share/go";
  };

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
    noto-fonts-color-emoji
  ];

  environment.systemPackages = with pkgs; [
    # web
    firefox
    ungoogled-chromium

    # file management
    rclone

    # theme
    adw-gtk3

    # code
    cargo
    python3
    git
    onefetch
    cmake
    lazygit
    gh
    gnumake
    helix
    neovim
    vim
    fd
    fzf
    pkg-config
    tree-sitter
    luajit
    luarocks
    clangStdenv
    ocaml
    opam
    rustup
    gcc
    ghc
    go
    nodejs
    pnpm
    nil
    vscode
    zed-editor

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
    imv

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
    upower
    man-pages
    man-pages-posix
    unzip
    dig
    nmap
    usbutils
    p7zip
    nfs-utils
    libnotify
    file

    # security
    authenticator
    bitwarden-desktop
    gnupg1

    # audio
    helvum

    # docs
    obsidian
    logseq
    tectonic
    xournalpp

    # music
    feishin
    nicotine-plus
    picard

    # image
    exiftool
    gimp
    imagemagick
    libwebp

    # communication
    thunderbird
    telegram-desktop
    signal-desktop

    # fonts
    liberation_ttf
    times-newer-roman

    # media
    calibre
    plex-mpv-shim
    obs-studio

    # gnome stuff
    glib
    snapshot
    gnome-calendar
    gnome-clocks
    nautilus
    gnome-calculator
    gnome-online-accounts
    gnome-online-accounts-gtk
    gnome-connections
    gnome-keyring
    adwaita-icon-theme
    adwaita-icon-theme-legacy
  ];

  haze.devices = {
    qudelix5k.enable = true;
    k3Pro.enable = true;
  };

  haze.services = {
    tailscale.enable = true;
  };
}
