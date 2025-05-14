{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.haze.windowManager.i3blocks.enable {
    home.file = {
      ".config/i3blocks/scripts/battery.sh" = {
        source = ./scripts/battery.sh;
        executable = true;
      };
      ".config/i3blocks/scripts/brightness.sh" = {
        source = ./scripts/brightness.sh;
        executable = true;
      };
      ".config/i3blocks/scripts/network.sh" = {
        source = ./scripts/network.sh;
        executable = true;
      };
      ".config/i3blocks/scripts/now_playing.sh" = {
        source = ./scripts/now_playing.sh;
        executable = true;
      };
      ".config/i3blocks/scripts/volume.sh" = {
        source = ./scripts/volume.sh;
        executable = true;
      };
    };

    programs.i3blocks = {
      enable = true;
      bars = {
        config = {

          music = {
            command = "~/.config/i3blocks/scripts/now_playing.sh";
            interval = 15;
          };

          network = lib.hm.dag.entryAfter [ "music" ] {
            command = "~/.config/i3blocks/scripts/network.sh";
            interval = 60;
          };

          brightness = lib.hm.dag.entryAfter [ "network" ] {
            command = "~/.config/i3blocks/scripts/brightness.sh";
            interval = "once";
            signal = 11;
          };

          volume = lib.hm.dag.entryAfter [ "brightness" ] {
            command = "~/.config/i3blocks/scripts/volume.sh";
            interval = 60;
            signal = 10;
          };

          battery = lib.hm.dag.entryAfter [ "volume" ] {
            command = "~/.config/i3blocks/scripts/battery.sh";
            interval = 60;
            signal = 12;
          };

          datetime = lib.hm.dag.entryAfter [ "battery" ] {
            command = "date '+%Y-%m-%d %I:%M %p'";
            interval = 60;
            signal = 13;
          };

        };
      };

    # TODO: figure out how to get this working from in here or somewhere else
    #   systemd.user = {
    #     timers."i3blocks-time-signal" = {
    #       description = "i3blocks time signal";
    #       timerConfig = {
    #         OnCalendar = "*:0/1"; # every minute
    #         Persistent = true;
    #       };
    #     };
    #     services."i3blocks-time-signal" = {
    #       Unit = {
    #         Description = "i3blocks time signal service";
    #       };
    #       Service = {
    #         Type = "oneshot";
    #         ExecStart = "${pkgs.procps}/bin/pkill -SIGRTMIN+13 i3blocks";
    #       };
    #     };
    #   };

    };
  };
}
