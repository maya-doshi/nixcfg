{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.haze.services.syncthing.enable {
    services.syncthing = {
      enable = true;
      user = "maya";
      dataDir = "/home/maya/";
      configDir = "/home/maya/.config/syncthing/";
    };
  };
}
