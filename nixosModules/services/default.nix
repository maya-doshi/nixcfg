{ config, lib, pkgs, ... }: {
  imports = [
    ./emacs
    ./syncthing
    ./tailscale
  ];
}
