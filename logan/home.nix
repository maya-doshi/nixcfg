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
      gh

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

      # pdf
      zathura
      sioyek

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

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        term = "xterm-256color";
        shell = "fish";
        font = "JetBrainsMono Nerd Font:size=12";
        dpi-aware = "no";
        workers = 12;
      };
      mouse = {
        hide-when-typing = "yes";
      };
      # TODO: Change to declarative themeing
      colors = {
        alpha="0.9";
        background="282828";
        foreground="ebdbb2";
        regular0="282828";
        regular1="cc241d";
        regular2="98971a";
        regular3="d79921";
        regular4="458588";
        regular5="b16286";
        regular6="689d6a";
        regular7="a89984";
        bright0="928374";
        bright1="fb4934";
        bright2="b8bb26";
        bright3="fabd2f";
        bright4="83a598";
        bright5="d3869b";
        bright6="8ec07c";
        bright7="ebdbb2";
      };
    };
  };
}
