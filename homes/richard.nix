{ config, pkgs, ... }:

{
  imports = [
    ./laptop.nix
  ];

  haze.apps.foot.font = "IosevkaTerm NF:size=10";
}
