{ config, lib, pkgs, ... }: {
  imports = [
    ./syncthing
    ./tailscale
  ];
}
