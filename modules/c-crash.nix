flake: {
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf mkMerge types;

  # Manifest via Cargo.toml
  # manifest = (pkgs.lib.importTOML ./Cargo.toml).workspace.package;
  manifest = {name = "CCrash"; };

  # Options
  cfg = config.services."${manifest.name}";

  # Flake shipped default binary
  fpkg = flake.packages.${pkgs.stdenv.hostPlatform.system}.default;

  # Toml management
  # toml = pkgs.formats.toml {};


  # Systemd services
  service = mkIf cfg.enable {


    systemd.services."${manifest.name}" = {
      description = "${manifest.name} daemon";
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${lib.getBin fpkg}/bin/cflake";

        Restart = "no";
        
        DevicePolicy="closed";
        KeyringMode="private";
        LockPersonality="yes";
        MemoryDenyWriteExecute="yes";
        NoNewPrivileges="yes";
        PrivateDevices="yes";
        PrivateTmp="true";
        ProtectClock="yes";
        ProtectControlGroups="yes";
        ProtectHome="read-only";
        ProtectHostname="yes";
        ProtectKernelLogs="yes";
        ProtectKernelModules="yes";
        ProtectKernelTunables="yes";
        ProtectProc="invisible";
        ProtectSystem="full";
        RestrictNamespaces="yes";
        RestrictRealtime="yes";
        RestrictSUIDSGID="yes";
        SystemCallArchitectures="native";
      };
    };
  };

in {
  # Available user options
  options = with lib; {
    services.${manifest.name} = {
      enable = mkEnableOption ''
        ${manifest.name}, C must crash.
      '';
    };
  };

  config = mkMerge [service];
}
