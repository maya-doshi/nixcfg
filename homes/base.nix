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
      logseq
      tectonic
      pandoc
      texliveSmall
      libreoffice-qt6-fresh

      # music
      nicotine-plus
      spotify
      spotify-player
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
      errands
      protonmail-bridge
      telegram-desktop
      signal-desktop
      vesktop

      # misc
      imv
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
      file
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
