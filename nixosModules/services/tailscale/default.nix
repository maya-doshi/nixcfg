{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.haze.services.tailscale.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    environment.systemPackages = [
      pkgs.trayscale
    ];
  };
}
