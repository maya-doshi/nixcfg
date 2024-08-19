{ config, lib, pkgs, ... }: {
  options.haze = {
    services = {
      syncthing.enable = lib.mkEnableOption "Syncthing - File Sync";
      tailscale.enable = lib.mkEnableOption "Tailscale - Split VPN";
    };
  };
}
