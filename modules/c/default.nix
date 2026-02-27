flake: {pkg}: {
  config,
  lib,
  pkgs,
  ...
}: let
  serviceName = "xinux-${pkg}";

  inherit (lib) mkEnableOption mkOption mkIf mkMerge types;

  # Manifest via Cargo.toml
  # manifest = (pkgs.lib.importTOML ./Cargo.toml).workspace.package;
  # manifest = {name = "CCrash";};

  # Options
  cfg = config.services.${serviceName};

  # Flake shipped default binary
  fpkg = flake.packages.${pkgs.stdenv.hostPlatform.system}.${pkg};

  # Toml management
  # toml = pkgs.formats.toml {};

  # Systemd services
  service = mkIf cfg.enable {
    systemd.services.${serviceName} = {
      description = "${serviceName} daemon";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${lib.getBin fpkg}/bin/cflake";

        Restart = "no";

        DevicePolicy = "closed";
        KeyringMode = "private";
        LockPersonality = "yes";
        MemoryDenyWriteExecute = "yes";
        NoNewPrivileges = "yes";
        PrivateDevices = "yes";
        PrivateTmp = "true";
        ProtectClock = "yes";
        ProtectControlGroups = "yes";
        ProtectHome = "read-only";
        ProtectHostname = "yes";
        ProtectKernelLogs = "yes";
        ProtectKernelModules = "yes";
        ProtectKernelTunables = "yes";
        ProtectProc = "invisible";
        ProtectSystem = "full";
        RestrictNamespaces = "yes";
        RestrictRealtime = "yes";
        RestrictSUIDSGID = "yes";
        SystemCallArchitectures = "native";
      };
    };
  };
in {
  # Available user options
  options = with lib; {
    services.${pkg} = {
      enable = mkEnableOption ''
        ${pkg}, C must crash.
      '';
    };
  };

  config = mkMerge [service];
}
