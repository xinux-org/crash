flake: {pkg}: {
  config,
  lib,
  pkgs,
  ...
}: let
  serviceName = "xinux-${pkg}";

  # cfg = lib.attrByPath ["services" pkg] {} config;
  cfg = config.services.${serviceName};

  main = lib.getExe flake.packages.${pkgs.stdenv.hostPlatform.system}.${pkg};
in {
  options = {
    services.${serviceName} = with lib; {
      enable = mkEnableOption "${serviceName}";

      user = mkOption {
        type = lib.types.str;
        default = "${serviceName}";
        example = "${serviceName}";
        description = "User for running systemd service as";
      };

      group = mkOption {
        type = types.str;
        default = "${serviceName}";
        example = "${serviceName}";
        description = "Group for user of running systemd service as";
      };

      dataDir = mkOption {
        type = types.str;
        default = "/var/lib/expius";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.user} = {
      description = "${serviceName} Service User";
      home = cfg.dataDir;
      useDefaultShell = true;
      inherit (cfg) group;
      isSystemUser = true;
    };

    users.groups.${cfg.group} = {};

    systemd.services.${serviceName} = {
      description = "${serviceName} server service";
      documentation = ["https://google.com"];

      wantedBy = ["multi-user.target"];

      serviceConfig = {
        User = cfg.user;
        Group = cfg.group;
        ExecStart = "${main}";
        StateDirectory = cfg.user;
        StateDirectoryMode = "0750";
      };
    };
  };
}
