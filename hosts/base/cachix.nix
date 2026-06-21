{ lib, pkgs, ... }:

let
  cache = import ../../cachix.nix;
  enabled = cache.enable or false;
  cacheName = cache.name or "";
  publicKey = cache.publicKey or "";
in
{
  assertions = lib.optionals enabled [
    {
      assertion = cacheName != "";
      message = "cachix.nix has enable = true, but name is empty.";
    }
    {
      assertion = publicKey != "";
      message = "cachix.nix has enable = true, but publicKey is empty.";
    }
  ];

  environment.systemPackages = [ pkgs.cachix ];

  nix.settings = lib.optionalAttrs enabled {
    extra-substituters = [ "https://${cacheName}.cachix.org" ];
    extra-trusted-public-keys = [ publicKey ];
  };
}
