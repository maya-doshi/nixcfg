{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "maya";
  home.homeDirectory = "/home/maya";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
      # code
      vscodium
      zed-editor
      lazygit
      ghc
      gh
      emacs29-pgtk

      # security
      bitwarden
      ## add a 2fa app
      # TODO - add a 2fa app

      # docs
      qownnotes
      libreoffice
      obsidian

      # music
      nicotine-plus
      strawberry
      spotifyd
      spotify-player
      shortwave
      picard

      # gaming
      steam
      prismlauncher

      # image
      gimp

      # latex
      tectonic

      # communication
      thunderbird
      protonmail-bridge
      telegram-desktop
      signal-desktop
      webcord

      # misc
      trayscale
      gnome.gnome-sound-recorder
      sqlitebrowser
      sqlite
  imports = [
    ../modules/home/wm/waybar/waybar.nix
    ../modules/home/wm/foot.nix
    ../modules/home/wm/fuzzel.nix
    ../modules/home/apps/sioyek.nix
    ../modules/home/apps/zathura.nix
  ];

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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
