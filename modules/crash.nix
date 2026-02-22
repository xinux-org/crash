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
        ExecStart = "${lib.getBin cfg.package}/bin/C-flake -g'app, ${lib.escapeShellArg cfg.greeter}!'";
        Restart = "once";
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
