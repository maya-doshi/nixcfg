{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./options.nix
    ./desktop
    ./devices
    ./services
    ./gaming
  ];
}
