{pkgs, ...}: let
  file = ../src/py.py;
in
  pkgs.stdenv.mkDerivation {
    pname = "py";
    version = "0.1.0";
    src = file;

    dontUnpack = true;

    propagatedBuildInputs = [
      (pkgs.python3.withPackages (
        pythonPackages:
          with pythonPackages; [
            # some dep
          ]
      ))
    ];

    installPhase = ''
      mkdir -p $out/bin
      cp ${file} $out/bin/py
      chmod +x $out/bin/py
    '';

    patchShebangs = true;

    meta.mainProgram = "py";
  }
