{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.haze.apps.mpv.enable {
    programs.mpv = {
      enable = true;

      package = (
        pkgs.mpv-unwrapped.wrapper {
          mpv = pkgs.mpv-unwrapped;

          scripts = with pkgs.mpvScripts; [
            # dynamic-crop
            thumbfast
            mpv-cheatsheet
            uosc
            sponsorblock
            quality-menu
            videoclip
          ];
        }
      );

      config = {
        profile = "high-quality";
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}
