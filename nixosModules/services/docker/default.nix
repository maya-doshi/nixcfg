{ config, pkgs, lib, ... }: {
  options = {
    haze.services.docker = {
      enable = lib.mkEnableOption "Containers";
    };
  };

  config = lib.mkIf config.haze.services.docker.enable {
    virtualisation.docker = {
      enable = true;
      autoPrune.enable = true;
    };
    virtualisation.oci-containers.backend = "docker";
  };
}
