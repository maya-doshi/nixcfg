{ config, pkgs, lib, ... }: {
  options = {
    haze.services.nextcloud = {
      enable = lib.mkEnableOption "nextcloud";
    };
  };

  config = lib.mkIf config.haze.services.nextcloud.enable {
    networking.firewall =  {
      allowedTCPPorts = [ 8666 8667 ];
    };

    virtualisation.oci-containers.containers."mariadb" = {
      image = "lscr.io/linuxserver/mariadb:latest";
      volumes = [
        "/mnt/old/250GB/bonus/appdata/nextcloud/db:/config:rw"
      ];
      environmentFiles = [
        "/mnt/old/250GB/bonus/appdata/nextcloud/db.env"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=nextcloud-mariadb"
        "--network=haze-dockernet"
      ];
    };
    systemd.services."docker-mariadb" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
        RestartMaxDelaySec = lib.mkOverride 90 "1m";
        RestartSec = lib.mkOverride 90 "100ms";
        RestartSteps = lib.mkOverride 90 9;
      };
      after = [
        "docker-network-haze-dockernet.service"
      ];
      requires = [
        "docker-network-haze-dockernet.service"
      ];
      partOf = [
        "docker-compose-nextcloud-root.target"
      ];
      wantedBy = [
        "docker-compose-nextcloud-root.target"
      ];
    };
    virtualisation.oci-containers.containers."nextcloud" = {
      image = "lscr.io/linuxserver/nextcloud:latest";
      environmentFiles = [
        "/mnt/old/250GB/bonus/appdata/nextcloud/nextcloud.env"
      ];
      volumes = [
        "/mnt/old/250GB/bonus/appdata/nextcloud/main:/config:rw"
        "/mnt/old/4TB/4TB/Nextcloud:/data:rw"
        "/mnt/old/4TB/4TB/Music:/music:ro"
      ];
      ports = [
        "8667:80"
        "8666:443/tcp"
      ];
      dependsOn = [
        "mariadb"
      ];
      log-driver = "journald";
      extraOptions = [
        "--network-alias=nextcloud"
        "--network=haze-dockernet"
      ];
    };
    systemd.services."docker-nextcloud" = {
      serviceConfig = {
        Restart = lib.mkOverride 90 "always";
        RestartMaxDelaySec = lib.mkOverride 90 "1m";
        RestartSec = lib.mkOverride 90 "100ms";
        RestartSteps = lib.mkOverride 90 9;
      };
      after = [
        "docker-network-haze-dockernet.service"
      ];
      requires = [
        "docker-network-haze-dockernet.service"
      ];
      partOf = [
        "docker-compose-nextcloud-root.target"
      ];
      wantedBy = [
        "docker-compose-nextcloud-root.target"
      ];
    };

    systemd.services."docker-network-haze-dockernet" = {
      path = [ pkgs.docker ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStop = "docker network rm -f haze-dockernet";
      };
      script = ''
        docker network inspect haze-dockernet || docker network create haze-dockernet
      '';
      partOf = [ "docker-compose-nextcloud-root.target" ];
      wantedBy = [ "docker-compose-nextcloud-root.target" ];
    };

    # Root service
    systemd.targets."docker-compose-nextcloud-root" = {
      unitConfig = {
        Description = "Root target generated by compose2nix.";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
