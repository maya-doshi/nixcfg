{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.haze.services.memos;
in
{
  options = {
    haze.services.memos = {
      enable = lib.mkEnableOption "Lightweight, self-hosted memo hub";

      dataDir = lib.mkOption {
        type = lib.types.str;
        default = "/var/lib/memos";
        description = ''
          The directory where Memos stores its data files.
        '';
      };

      port = lib.mkOption {
        type = lib.types.port;
        default = 5230;
        description = ''
          The port on which Memos listens for incoming connections.
        '';
      };

      uid = lib.mkOption {
        type = lib.types.int;
        default = 242;
        description = ''
          yoinked from emby
        '';
      };

      gid = lib.mkOption {
        type = lib.types.int;
        default = 242;
        description = ''
          yoinked from emby
        '';
      };

      openFirewall = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = ''
          Open ports in the firewall.
        '';
      };

      user = lib.mkOption {
        type = lib.types.str;
        default = "memos";
        description = ''
          User account under which Memos runs.
        '';
      };

      group = lib.mkOption {
        type = lib.types.str;
        default = "memos";
        description = ''
          Group under which Memos runs.
        '';
      };

      package = lib.mkPackageOption pkgs "memos" {
        extraDescription = ''
          Which Memos package to use.
        '';
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.services.memos = {
      description = "Memos Server";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        User = cfg.user;
        Group = cfg.group;

        # Run the pre-start script with full permissions (the "!" prefix) so it
        # can create the data directory if necessary.
        ExecStartPre =
          let
            preStartScript = pkgs.writeScript "memos-run-prestart" ''
              #!${pkgs.bash}/bin/bash

              # Create data directory if it doesn't exist
              if ! test -d "$MEMOS_DATA"; then
                echo "Creating initial Memos data directory in: $MEMOS_DATA"
                install -d -m 0755 -o "${cfg.user}" -g "${cfg.group}" "$MEMOS_DATA"
              fi
            '';
          in
          "!${preStartScript}";

        ExecStart = "${cfg.package}/bin/memos --mode prod --port ${toString cfg.port} --data ${cfg.dataDir}";
        KillSignal = "SIGQUIT";
        Restart = "on-failure";

        # Hardening
        NoNewPrivileges = true;
        PrivateTmp = true;
        ProtectSystem = true;
        ProtectHome = true;
        ProtectControlGroups = true;
        ProtectKernelModules = true;
        ProtectKernelTunables = true;
        RestrictAddressFamilies = [
          "AF_UNIX"
          "AF_INET"
          "AF_INET6"
          "AF_NETLINK"
        ];
        RestrictNamespaces = true;
        RestrictRealtime = true;
        RestrictSUIDSGID = true;
        MemoryDenyWriteExecute = true;
        LockPersonality = true;
      };

      environment = {
        MEMOS_DATA = cfg.dataDir;
        LC_ALL = "en_US.UTF-8";
        LANG = "en_US.UTF-8";
      };
    };

    networking.firewall = lib.mkIf cfg.openFirewall {
      allowedTCPPorts = [ cfg.port ];
    };

    users.users = lib.mkIf (cfg.user == "memos") {
      memos = {
        group = cfg.group;
        uid = cfg.uid;
      };
    };

    users.groups = lib.mkIf (cfg.group == "memos") {
      memos = {
        gid = cfg.gid;
      };
    };
  };
}
