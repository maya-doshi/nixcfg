{ config, lib, pkgs, modulesPath, ... }:
{
  boot.supportedFilesystems = [
    "nfs"
    "zfs"
  ];

  services.rpcbind.enable = true;

  services.zfs = {
    autoScrub = {
      enable = true;
      pools = [ "elena" ];
      interval = "monthly";
    };
  };

  fileSystems = {
    "/mnt/elena" = {
      device = "elena";
      fsType = "zfs";
    };

    "/mnt/elena/media" = {
      device = "elena/media";
      fsType = "zfs";
    };

    "/mnt/elena/safe" = {
      device = "elena/safe";
      fsType = "zfs";
    };

    "/mnt/elena/0xcad" = {
      device = "elena/0xcad";
      fsType = "zfs";
    };

   "/mnt/old/5TB" = {
     device = "/dev/disk/by-uuid/9dd0854f-3b10-4553-9a56-a2d6ad97764d";
     fsType = "btrfs";
     options = [
       "nofail"
       "compress=zstd:15"
       "noatime"
     ];
   };
  };
}
