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
    "/mnt/goliath" = {
      device = "172.24.97.48:mnt/goliath/maya-test";
      fsType = "nfs";
      options = [
        "nfsvers=4.2"
        "default"
        "nofail"
      ];
    };

    "/mnt/elena" = {
      device = "elena";
      fsType = "zfs";
    };

    "/mnt/elena/media" = {
      device = "elena/media";
      fsType = "zfs";
    };

    "/mnt/elena/0xcad" = {
      device = "elena/0xcad";
      fsType = "zfs";
    };

    "/mnt/old/250GB/boot" = {
      device = "/dev/disk/by-uuid/77b313c9-abf8-4471-bf49-55c8a9abd492";
      fsType = "ext4";
      options = [
        "nofail"
      ];
    };

    "/mnt/old/250GB/bonus" = {
      device = "/dev/disk/by-partuuid/1da29dd6-02";
      fsType = "btrfs";
      options = [
        "nofail"
      ];
    };

   "/mnt/old/1TB" = {
     device = "/dev/disk/by-uuid/03d0c2e4-3dc3-4b68-b130-951a0b077b6a";
     fsType = "btrfs";
     options = [
       "nofail"
     ];
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
