{ config, pkgs, self, ... }:
{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
      # code
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

      # security
      authenticator
      bitwarden
      gnupg1

      # docs
      obsidian
      tectonic
      pandoc
      texliveSmall

      # music
      nicotine-plus
      strawberry
      plexamp
      shortwave
      picard

      # image
      exiftool
      gimp
      imagemagick
      libwebp

      # communication
      thunderbird
      protonmail-bridge
      telegram-desktop
      signal-desktop
      vesktop

      # sway stuff
      sway-contrib.grimshot
      swaynotificationcenter
      brightnessctl
      acpi
      wirelesstools
      playerctl
      pwvucontrol
      rofimoji
      swaylock
      wl-clipboard
      nwg-displays
      imv
      wdisplays
      yazi

      # misc
      ungoogled-chromium
      man-pages
      man-pages-posix
      liberation_ttf
      times-newer-roman
      calibre
      qpwgraph
      plex-mpv-shim
      unzip
      dig
      nmap
      usbutils
      p7zip
      nfs-utils
      libnotify
  ];

  imports = [
    ../homeManagerModules
    self.inputs.zen-browser.homeModules.default
  ];

  haze.apps = {
    sioyek.enable = true;
    zathura.enable = true;
    foot.enable = true;
    mpv.enable = true;
    fuzzel.enable = true;
  };

  haze.windowManager.sway.enable = true;

  home.file = {};

  home.sessionVariables = {};

  programs = {
    home-manager.enable = true; # Let Home Manager install and manage itself.
    zen-browser.enable = true;
  };
}
