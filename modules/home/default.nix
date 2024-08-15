{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./options.nix
    ./apps
    ./wm
  ];
}
