{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.haze.devices.qudelix5k.enable {
    # Quedelix 5K. Rules are for all samplerates cause the id changes
    services.udev.extraRules = ''
      KERNEL=="hidraw*", ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="4003", MODE="0666"
      KERNEL=="hidraw*", ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="4004", MODE="0666"
      KERNEL=="hidraw*", ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="4005", MODE="0666"
      KERNEL=="hidraw*", ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="4006", MODE="0666"
      KERNEL=="hidraw*", ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="4007", MODE="0666"
      KERNEL=="hidraw*", ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="4125", MODE="0666"
      KERNEL=="hidraw*", ATTRS{idVendor}=="0a12", ATTRS{idProduct}=="4126", MODE="0666"
    '';
  };
}
