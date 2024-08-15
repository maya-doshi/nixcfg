{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./apps
    ./wm
  ];
}
