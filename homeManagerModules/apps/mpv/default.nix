{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.haze.apps.mpv.enable {
    programs.mpv = {
      enable = true;

      package = (
        pkgs.mpv-unwrapped.wrapper {
          scripts = with pkgs.mpvScripts; [
            dynamic-crop
            thumbfast
            mpv-cheatsheet
            uosc
            sponsorblock
            quality-menu
            visualizer
            videoclip
          ];

          mpv = pkgs.mpv-unwrapped.override {
            waylandSupport = true;
            cddaSupport = true;
            sixelSupport = true;
          };
        }
      );

      config = {
        profile = "high-quality";
        ytdl-format = "bestvideo+bestaudio";
      };
    };
  };
}
