{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./options.nix
    ./devices
    ./services
    ./gaming
  ];
}
