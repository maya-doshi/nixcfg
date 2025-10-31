{ config, pkgs, self, ... }:

{
  home.username = "haze";
  home.homeDirectory = "/home/haze";

  imports = [
    ./base.nix
  ];

  haze.apps = {
    sioyek.enable = true;
    zathura.enable = true;
    foot.enable = true;
    mpv.enable = true;
    fuzzel.enable = true;
  };

  haze.isDesktop = true;
  haze.windowManager.sway.enable = true;

  wayland.windowManager.sway = {
    extraOptions = [ "--unsupported-gpu" ];
    config.output = {
      "DP-1" = {
        mode = "3840x2160@60.0Hz";
        pos = "0 0";
        transform = "normal";
        scale = "1.50";
        adaptive_sync = "on";
        dpms = "on";
      };
    };
  };

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
  };

  # services.emacs = {
  #   enable = true;
  #   package = pkgs.emacs29-pgtk;
  # };
}
