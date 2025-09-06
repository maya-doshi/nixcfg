{ config, lib, pkgs, modulesPath, ... }:
{
  boot.supportedFilesystems = [ "nfs" ];
  services.rpcbind.enable = true;

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

    "/mnt/old/250GB/boot" = {
      device = "/dev/disk/by-partuuid/1da29dd6-02";
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

   "/mnt/old/4TB"  ={
     device = "/dev/disk/by-uuid/1cf6b2ad-86a8-42e9-9174-245145d8ce18";
     fsType = "btrfs";
     options = [
       "nofail"
     ];
   };

   "/mnt/old/5TB"  ={
     device = "/dev/disk/by-uuid/3E8E57D38E5781F7";
     fsType = "ntfs";
   };
  };
}
