{ config, lib, pkgs, ... }:

{
  options.maya.apps.waybar.enable = lib.mkEnableOption "Enable Waybar";

  config = lib.mkIf config.maya.apps.waybar.enable {
    programs.waybar = {
      enable = true;
      style = ./style.css;
      settings = {
        mainBar = {
          "layer" = "top";
          "position" = "top";
          "height" = 24;
          "margin" = "0, 0, 0, 0";
          "ipc" = true;

          "modules-left" = ["sway/workspaces" "sway/scratchpad" "sway/mode"];
          "modules-center" = ["mpris"];
          "modules-right" = ["tray" "backlight" "pulseaudio" "battery" "clock"];

          "sway/scratchpad" = {
            "format" = "{icon} {count}";
            "show-empty" = false;
            "format-icons" = ["" ""];
            "tooltip" = true;
            "tooltip-format" = "{app}: {title}";
          };

          "idle_inhibitor" = {
            "format" = "{icon}";
            "format-icons" = {
              "activated" = "";
              "deactivated" = "";
            };
          };
          "clock" = {
            "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
            "format-alt" = "{:%Y-%m-%d}";
          };
          "backlight" = {
            "format" = "{percent}% {icon}";
            "format-icons" = ["" "" "" "" "" "" "" "" ""];
          };
          "pulseaudio" = {
            "format" = "{volume}% {icon} {format_source}";
            "format-bluetooth" = "{volume}% {icon} {format_source}";
            "format-bluetooth-muted" = " {icon} {format_source}";
            "format-muted" = "  {format_source}";
            "format-source" = "{volume}% ";
            "format-source-muted" = "";
            "format-icons" = {
              "headphone" = "󰋋";
              "hands-free" = "󰥰";
              "headset" = "󰋎";
              "phone" = "";
              "portable" = "";
              "car" = "";
              "default" = ["" "" ""];
            };
            "on-click" = "pavucontrol";
          };
          "battery" = {
            "states" = {
              "good" = 95;
              "warning" = 30;
              "critical" = 15;
            };
            "format" = "{capacity}% {icon}";
            "format-charging" = "{capacity}% 󱐋";
            "format-plugged" = "{capacity}% ";
            "format-alt" = "{time} {icon}";
            "format-icons" = ["" "" "" "" ""];
          };
          "mpris" = {
            "format" = "{player_icon} {dynamic}";
            "format-paused" = "{status_icon} <i>{dynamic}</i>";
            "player-icons" = {
              "default" = "▶";
              "spotify_player" = "🎵";
              "strawberry" = "🎵";
            };
            "status-icons" = {
              "paused" = "⏸";
            };
            "ignored-players" = ["firefox"];
            "on-click" = "playerctl pause media";
          };
        };
      };
    };
  };
}
