file: {pkgs, ...}: let
  path = ../../src/python;

  name = "${file.name}.py";
in
  pkgs.stdenv.mkDerivation {
    pname = name;
    version = "0.1.0";
    src = path;

    # propagatedBuildInputs = [
    #   (pkgs.python3.withPackages (
    #     pythonPackages:
    #       with pythonPackages; [
    #         # some dep
    #       ]
    #   ))
    # ];

    # dontUnpack = true;

    nativeBuildInputs = with pkgs; [
      # breakpointHook
      # cntr
    ];

    buildInputs = with pkgs; [
      python3
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp ./${name} $out/bin/main
      chmod +x $out/bin/main
    '';

    patchShebangs = true;

    meta.mainProgram = "main";
  }
