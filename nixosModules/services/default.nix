{ config, lib, pkgs, ... }: {
  imports = [
    ./docker
    ./emacs
    ./memos
    ./syncthing
    ./tailscale
  ];
}
