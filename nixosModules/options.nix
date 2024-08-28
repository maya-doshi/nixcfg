{ config, lib, pkgs, ... }: {
  options.haze = {
    services = {
      syncthing.enable = lib.mkEnableOption "Syncthing - File Sync";
      tailscale.enable = lib.mkEnableOption "Tailscale - Split VPN";
    };
    gaming = {
      steam.enable = lib.mkEnableOption "Steam";
      emu = {
        dolphin = {
          enable = lib.mkEnableOption "Enable Wii/GC emulation";
          gc-oc = lib.mkEnableOption "GC Adapter Overclock kernel modules";
        };
      };
    };
  };
}
