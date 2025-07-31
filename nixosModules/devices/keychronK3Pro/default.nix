{ config, lib, pkgs, ... }: {
  options.haze.devices.k3Pro.enable = lib.mkEnableOption "Keychron K3 Pro UDEV rules";
  config = lib.mkIf config.haze.devices.k3Pro.enable {
    services.udev.extraRules = ''
      KERNEL=="hidraw*", ATTRS{idVendor}=="3434", ATTRS{idProduct}=="0233", MODE="0666"
    '';
  };
}
