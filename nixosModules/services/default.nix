{ config, lib, pkgs, ... }: {
  imports = [
    ./emacs
    ./memos
    ./syncthing
    ./tailscale
  ];
}
