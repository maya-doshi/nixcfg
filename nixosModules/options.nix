{ config, lib, pkgs, ... }: {
  options.haze = {
    devices.qudelix5k.enable = lib.mkEnableOption "Qudelix 5K Bluetooth UDEV rules";
    services = {
      syncthing.enable = lib.mkEnableOption "Syncthing - File Sync";
      tailscale.enable = lib.mkEnableOption "Tailscale - Split VPN";
      emacs.enable = lib.mkEnableOption "EMACS";
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
