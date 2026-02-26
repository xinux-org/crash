{
  pkgs,
  file,
  ...
}: let
  filename = "../../src/python${file}";
in
  pkgs.stdenv.mkDerivation {
    pname = "py";
    version = "0.1.0";
    src = filename;

    dontUnpack = true;

    # propagatedBuildInputs = [
    #   (pkgs.python3.withPackages (
    #     pythonPackages:
    #       with pythonPackages; [
    #         # some dep
    #       ]
    #   ))
    # ];

    installPhase = ''
      mkdir -p $out/bin
      cp ${filename} $out/bin/py
      chmod +x $out/bin/py
    '';

    patchShebangs = true;

    meta.mainProgram = "py";
  }
