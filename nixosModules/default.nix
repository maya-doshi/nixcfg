{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./options.nix
    ./services
    ./gaming
  ];
}
