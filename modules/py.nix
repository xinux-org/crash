flake: {
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.py-flake;

  main = lib.getExe flake.packages.${pkgs.stdenv.hostPlatform.system}.py;
in {
  options = {
    services.py-flake = with lib; {
      enable = mkEnableOption "py-flake";

      user = mkOption {
        type = lib.types.str;
        default = "py-flake";
        example = "py-flake";
        description = "User for running systemd service as";
      };

      group = mkOption {
        type = types.str;
        default = "py-flake";
        example = "py-flake";
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

    systemd.services.py-flake = {
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
