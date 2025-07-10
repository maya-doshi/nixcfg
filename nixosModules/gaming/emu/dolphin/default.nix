{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.haze.gaming.emu.dolphin.enable {
    services.udev.packages = [ pkgs.dolphin-emu ];
    users.users.${config.haze.user}.packages = [ pkgs.dolphin-emu ];

    boot = lib.mkIf config.haze.gaming.emu.dolphin.gc-oc {
      extraModulePackages = [
        config.boot.kernelPackages.gcadapter-oc-kmod
      ];
      kernelModules = [
        "gcadapter_oc"
      ];
    };
  };
}
