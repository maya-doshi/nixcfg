{ config, lib, pkgs, ... }:

# TODO:
# - [ ] Move sway stuff packages in here
# - [ ] Import foot and other modules in here
# - [ ] Bind extra keys

{
  config = lib.mkIf config.haze.windowManager.sway.enable {
    wayland.windowManager.sway = let
      mod = "Mod4";
      term = "footclient";
      termServer = "foot --server";
      web = "firefox";
      menu = "fuzzel";
      clipboard = "wl-copy";
      emoji = "rofimoji --selector '${menu}' --clipboarder '${clipboard}'";
      todo = "io.github.alainm23.planify.quick-add";

      up = "k";
      down = "j";
      left = "h";
      right = "l";

      screenshot_select = "grimshot --notify copy area";
      screenshot_select_save = "grimshot --notify save area";
      screenshot_all = "grimshot --notify copy screen";
      screenshot_all_save = "grimshot --notify save screen";

      notify = "swaync";
    in {
      enable = true;
      wrapperFeatures.gtk = true;
      checkConfig = false; # TODO: remove this once you figure out how to set the wallpaper properly
      systemd.enable = true;
      config = {
        modifier = "${mod}";
        terminal = "${term}";
        menu = "${menu}";

        startup = [
          {command = "${termServer}";}
          {command = "${notify}";}
        ];

        window = {
          border = 3;
          titlebar = false;
          hideEdgeBorders = "smart";
        };

        defaultWorkspace = "workspace number 1";

        focus = {
          followMouse = "always";
          newWindow = "focus";
          mouseWarping = "container";
        };

        colors = {
          focused = {
            border = "#8EC07C";
            background = "#282828";
            text = "#ebdbb2";
            indicator = "#8EC07C";
            childBorder = "#8EC07C";
          };
          focusedInactive = {
            border = "#282828";
            background = "#282828";
            text = "#ebdbb2";
            indicator = "#404040";
            childBorder = "#282828";
          };
          unfocused = {
            border = "#282828";
            background = "#282828";
            text = "#ebdbb2";
            indicator = "#404040";
            childBorder = "#282828";
          };
          urgent = {
            border = "#2f343a";
            background = "#fb4934";
            text = "#ebdbb2";
            indicator = "#404040";
            childBorder = "#8EC07C";
          };
          placeholder = {
            border = "#282828";
            background = "#282828";
            text = "#ebdbb2";
            indicator = "#404040";
            childBorder = "#8EC07C";
          };
        };

        bars = [
          {
            fonts =  {
              names = [ "JetBrains Mono Nerd Font" ];
              style = "Regular";
              size = 9.0;
            };
            position = "top";
            colors = {
              background = "#282828";
              focusedWorkspace = {
                background = "#8EC07C";
                border = "#8EC07C";
                text = "#282828";
              };
              inactiveWorkspace = {
                background = "#282828";
                border = "#282828";
                text = "#ebdbb2";
              };
              statusline = "#ebdbb2";
            };
            extraConfig =
              "workspace_min_width 25\n" +
              "status_command i3blocks";
          }
        ];

        seat."*".xcursor_theme = "Adwaita 24";

        input = {
          "type:touchpad" = {
            dwt = "enabled";
            tap = "enabled";
            natural_scroll = "enabled";
            middle_emulation = "enabled";
          };

          "type:keyboard" = {
            xkb_options = "ctrl:nocaps";
          };

          "1267:11830:ELAN9008:00_04F3:2E36" = {
            events = "disabled";
            map_to_output = "eDP-1";
          };

          "1267:11830:ELAN9008:00_04F3:2E36_Stylus" = {
            events = "disabled";
            map_to_output = "eDP-1";
          };
        };

        output = {
          "eDP-1" = {
            mode = "2880x1800@90.001Hz";
            pos = "2560 0";
            transform = "normal";
            scale = "1.50";
            adaptive_sync = "off";
            dpms = "on";
          };
          "DP-1" = {
            mode = "3840x2160@60.0Hz";
            pos = "0 0";
            transform = "normal";
            scale = "1.50";
            adaptive_sync = "off";
            dpms = "on";
          };
          "DP-2" = {
            mode = "3840x2160@60.0Hz";
            pos = "0 0";
            transform = "normal";
            scale = "1.50";
            adaptive_sync = "off";
            dpms = "on";
          };

          "*" = {
            bg = "~/Pictures/Wallpapers/zoro_luffy2.jpg fill";
          };
        };

        up = "k";
        down = "j";
        left = "h";
        right = "l";

        keybindings = {
          # App Shortcuts
          "${mod}+Return" = "exec ${term}";
          "${mod}+bracketright" = "exec ${web}";
          "${mod}+apostrophe" = "exec ${todo}";

          # Menu Commands
          "${mod}+d" = "exec ${menu}";
          "${mod}+i" = "exec ${emoji}";

          # Screenshot
          "${mod}+p" = "exec ${screenshot_select}";
          "${mod}+Shift+p" = "exec ${screenshot_select_save}";
          "${mod}+Control+p" = "exec ${screenshot_all}";
          "${mod}+Control+Shift+p" = "exec ${screenshot_all_save}";

          # Sway Commands
          "${mod}+Shift+q" = "kill";
          "${mod}+Shift+r" = "reload";
          "${mod}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'";

          # Movement
          ## Focus
          "${mod}+${left}" = "focus left";
          "${mod}+${down}" = "focus down";
          "${mod}+${up}" = "focus up";
          "${mod}+${right}" = "focus right";
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";
          ## Container
          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${right}" = "move right";
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";
          ## Workspace to output
          "${mod}+Control+Shift+${left}" = "move workspace to output left";
          "${mod}+Control+Shift+${right}" = "move workspace to output right";
          "${mod}+Control+Shift+${up  }" = "move workspace to output up";
          "${mod}+Control+Shift+${down}" = "move workspace to output down";
          "${mod}+Control+Shift+Left" = "move workspace to output left";
          "${mod}+Control+Shift+Right" = "move workspace to output right";
          "${mod}+Control+Shift+Up  " = "move workspace to output up";
          "${mod}+Control+Shift+Down" = "move workspace to output down";

          # Workspaces
          ## Switching
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";
          "${mod}+m" = "workspace 󰝚";
          "${mod}+t" = "workspace ";
          "${mod}+n" = "workspace ";
          "${mod}+c" = "workspace ";
          ## Move focused container
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";
          "${mod}+Shift+m" = "move container to workspace 󰝚";
          "${mod}+Shift+t" = "move container to workspace ";
          "${mod}+Shift+n" = "move container to workspace ";
          "${mod}+Shift+c" = "move container to workspace ";

          # Scratchpad
          "${mod}+Shift+minus" = "move scratchpad";
          "${mod}+minus" = "scratchpad show";
          "${mod}+Shift+f" = "[app_id=\"org.gnome.Nautilus\"] scratchpad show";

          # Layout
          ## Splits
          "${mod}+b" = "splith";
          "${mod}+v" = "splitv";
          ## Styles
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";
          ## Misc
          "${mod}+f" = "fullscreen";
          "${mod}+a" = "focus parent";
          ### Floating stuff
          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";

          "${mod}+r" = "mode \"resize\"";
        };

        modes = {
          resize = {
            Left = "resize shrink width 10 px";
            Right = "resize grow width 10 px";
            Up = "resize shrink height 10 px";
            Down = "resize grow height 10 px";
            h = "resize shrink width 10 px";
            l = "resize grow width 10 px";
            j = "resize grow height 10 px";
            k = "resize shrink height 10 px";
            Escape = "mode default";
            Return = "mode default";
          };
        };

        floating = {
          modifier = "${mod}";
          titlebar = false;
          criteria = [
            { window_role = "pop-up"; }
            { window_role = "Pop-up"; }
            { window_role = "bubble"; }
            { window_role = "Bubble"; }
            { window_role = "dialogue"; }
            { window_role = "Dialogue"; }
            { window_role = "task_dialog"; }
            { window_role = "About"; }

            { class = "dialog"; }
            { class = "Dialog"; }

            { app_id = "pavucontrol"; }
            { app_id = "xdg-desktop-portal-*"; }
            { app_id = "org.telegram.desktop"; }
            { app_id = "org.gnome.clocks"; }
            { app_id = "org.gnome.Nautilus"; }
            { app_id = "org.gnome.Snapshot"; }
            { app_id = "org.gnome.Fractal"; }
            { app_id = "org.gnome.Calculator"; }
            { app_id = "dev.deedles.Trayscale"; }
            { app_id = "io.github.alainm23.planify"; }
            { app_id = ".blueman-manager-wrapped"; }
            { app_id = "Bitwarden"; }

            { app_id = "firefox"; title = "Firefox - Sharing Indicator"; }
            { app_id = "firefox"; title = "Picture-in-Picture"; }
            { app_id = "thunderbird"; title = "New*"; }

            { title = "Steam - News"; }
          ];
        };
      };

      extraConfig = let
        brightness_signal = "pkill -SIGRTMIN+11 i3blocks";
        brightness_up   = "brightnessctl set 5%+ && ${brightness_signal}";
        brightness_down = "brightnessctl set 5%- && ${brightness_signal}";

        vol_signal = "pkill -SIGRTMIN+10 i3blocks";
        vol_mute = "pactl set-sink-mute @DEFAULT_SINK@ toggle && ${vol_signal}";
        vol_up   = "pactl set-sink-volume @DEFAULT_SINK@ +5%  && ${vol_signal}";
        vol_down = "pactl set-sink-volume @DEFAULT_SINK@ -5%  && ${vol_signal}";

        lock = "swaylock -c \"#1e1e2e\" --ring-color \"#D2ABDB\" | systemctl suspend";
      in ''
        bindsym --locked XF86MonBrightnessUp exec ${brightness_up}
        bindsym --locked XF86MonBrightnessDown exec ${brightness_down}

        ## Media
        bindsym --locked XF86AudioRaiseVolume exec ${vol_up}
        bindsym --locked XF86AudioLowerVolume exec ${vol_down}
        bindsym --locked XF86AudioMute exec ${vol_mute}

        bindsym --locked XF86AudioPlay exec playerctl play-pause
        bindsym --locked XF86AudioPause exec playerctl pause

        bindsym --locked XF86AudioNext exec playerctl next
        bindsym --locked XF86AudioPrev exec playerctl previous

        bindswitch --reload --locked lid:on exec ${lock}
      '';
      # TODO: Bind these
      # bindsym --locked XF86AudioMicMute exec ${mic_mute}
      # bindsym --locked XF86AudioPlay exec ${media_play}
      # bindsym --locked XF86AudioPrev exec ${media_prev}
      # bindsym --locked XF86AudioNext exec ${media_next}
      # bindsym --locked XF86Launch2 exec ${media_play}
    };
  };
}
