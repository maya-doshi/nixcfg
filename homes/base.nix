{ config, pkgs, self, ... }:
{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
      # code
      lazygit
      gh
      gnupg1

      # security
      bitwarden
      bitwarden-cli
      ## add a 2fa app
      # TODO - add a 2fa app

      # docs
      libreoffice
      obsidian

      # music
      nicotine-plus
      strawberry
      spotify
      spotifyd
      spotify-player
      plexamp
      shortwave
      picard

      # image
      gimp

      # latex
      tectonic

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
      wdisplays

      # misc
      ungoogled-chromium
      man-pages
      man-pages-posix
      liberation_ttf
      times-newer-roman
      calibre
      plex-mpv-shim
      endeavour
      helix
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

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/maya/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs = {
    home-manager.enable = true; # Let Home Manager install and manage itself.
    zen-browser.enable = true;
  };

  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs29-pgtk;
  # };
}
