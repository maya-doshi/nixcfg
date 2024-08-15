{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./sioyek
    ./zathura
    ./waybar
    ./foot
    ./fuzzel
  ];
}
