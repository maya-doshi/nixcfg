{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./i3blocks
    ./sway
    ./swaync
  ];
}
