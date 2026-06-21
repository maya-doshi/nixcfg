{ config, lib, pkgs, ... }:

let
  cfg = config.haze.desktop;
  user = config.haze.user;
  home = "/home/${user}";
  dotfiles = ../../dotfiles/.config;
  host = config.networking.hostName;

  footConfig =
    if host == "richard"
    then "${dotfiles}/foot/foot-richard.ini"
    else "${dotfiles}/foot/foot.ini";

  i3blocksConfig =
    if host == "oliver"
    then "${dotfiles}/i3blocks/config-desktop"
    else "${dotfiles}/i3blocks/config";

  swayHostOutput =
    if host == "logan"
    then "${dotfiles}/sway/hosts/logan"
    else if host == "oliver"
    then "${dotfiles}/sway/hosts/oliver"
    else "${dotfiles}/sway/hosts/richard";

  mpvWithScripts = pkgs.mpv.override {
    scripts = with pkgs.mpvScripts; [
      thumbfast
      mpv-cheatsheet-ng
      uosc
      sponsorblock
      quality-menu
      videoclip
    ];
  };
in
{
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      foot
      fuzzel
      rofimoji
      mpvWithScripts
      sioyek
      zathura
      i3blocks
      swaynotificationcenter

      sway-contrib.grimshot
      brightnessctl
      acpi
      wirelesstools
      playerctl
      pwvucontrol
      swaylock
      wl-clipboard
      nwg-displays
      wdisplays
      yazi
      xwayland-satellite
    ] ++ lib.optionals (host == "logan") [
      ryzenadj
      ryzen-monitor-ng
    ];

    system.activationScripts.hazeDotfiles = {
      deps = [ "users" ];
      text = ''
        home=${lib.escapeShellArg home}
        user=${lib.escapeShellArg user}

        if [ -d "$home" ]; then
          install -d -o "$user" -g users \
            "$home/.config/foot" \
            "$home/.config/fuzzel" \
            "$home/.config/mpv" \
            "$home/.config/sioyek" \
            "$home/.config/zathura" \
            "$home/.config/sway" \
            "$home/.config/swaync" \
            "$home/.config/i3blocks/scripts"

          ln -sfnT ${lib.escapeShellArg footConfig} "$home/.config/foot/foot.ini"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/fuzzel/fuzzel.ini"} "$home/.config/fuzzel/fuzzel.ini"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/mpv/mpv.conf"} "$home/.config/mpv/mpv.conf"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/sioyek/prefs_user.config"} "$home/.config/sioyek/prefs_user.config"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/sioyek/keys_user.config"} "$home/.config/sioyek/keys_user.config"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/zathura/zathurarc"} "$home/.config/zathura/zathurarc"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/sway/config"} "$home/.config/sway/config"
          ln -sfnT ${lib.escapeShellArg swayHostOutput} "$home/.config/sway/host-output"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/sway/wallpaper.png"} "$home/.config/sway/wallpaper.png"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/swaync/config.json"} "$home/.config/swaync/config.json"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/swaync/style.css"} "$home/.config/swaync/style.css"
          ln -sfnT ${lib.escapeShellArg i3blocksConfig} "$home/.config/i3blocks/config"

          ln -sfnT ${lib.escapeShellArg "${dotfiles}/i3blocks/scripts/network.sh"} "$home/.config/i3blocks/scripts/network.sh"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/i3blocks/scripts/now_playing.sh"} "$home/.config/i3blocks/scripts/now_playing.sh"
          ln -sfnT ${lib.escapeShellArg "${dotfiles}/i3blocks/scripts/volume.sh"} "$home/.config/i3blocks/scripts/volume.sh"

          if [ ${lib.escapeShellArg host} != oliver ]; then
            ln -sfnT ${lib.escapeShellArg "${dotfiles}/i3blocks/scripts/battery.sh"} "$home/.config/i3blocks/scripts/battery.sh"
            ln -sfnT ${lib.escapeShellArg "${dotfiles}/i3blocks/scripts/brightness.sh"} "$home/.config/i3blocks/scripts/brightness.sh"
          fi
        fi
      '';
    };
  };
}
