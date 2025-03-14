{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./foot
    ./fuzzel
    ./mpv
    ./sioyek
    ./waybar
    ./zathura
  ];
}
