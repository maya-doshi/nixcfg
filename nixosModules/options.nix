{ config, lib, pkgs, ... }: {
  options.maya = {
    services = {
      syncthing.enable = lib.mkEnableOption "Syncthing - File Sync";
    };
  };
}
