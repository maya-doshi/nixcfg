{ config, lib, pkgs, ... }: {
  imports = [
    ./docker
    ./emacs
    ./memos
    ./nextcloud
    ./syncthing
    ./tailscale
  ];
}
