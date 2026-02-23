flake: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.java-flake;

  main = lib.getExe flake.packages.${pkgs.stdenv.hostPlatform.system}.java;
in {
  options = {
    services.java-flake = with lib; {
      enable = mkEnableOption "java-flake";

      user = mkOption {
        type = lib.types.str;
        default = "java-flake";
        example = "java-flake";
        description = "User for running systemd service as";
      };

      group = mkOption {
        type = types.str;
        default = "java-flake";
        example = "java-flake";
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
      description = "Experimentalus Service User";
      home = cfg.dataDir;
      useDefaultShell = true;
      inherit (cfg) group;
      isSystemUser = true;
    };

    users.groups.${cfg.group} = {};

    systemd.services.java-flake = {
      description = "Experimentalus server service";
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
