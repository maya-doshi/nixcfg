{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.maya.services.syncthing.enable {
    services.syncthing = {
      enable = true;
      user = "maya";
      dataDir = "/home/maya/";
      configDir = "/home/maya/.config/syncthing/";
    };
  };
}
