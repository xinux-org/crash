file: {pkgs}: let
  path = ../../src/java;

  name = "${file.name}.java";

  class = lib.strings.removeSuffix ".java" name;

  lib = pkgs.lib;
in
  pkgs.stdenv.mkDerivation rec {
    pname = name;
    version = "1.0.0";

    src = path;

    nativeBuildInputs = [pkgs.jdk];

    buildInputs = [pkgs.jdk];

    dontUnpack = false;

    buildPhase = ''
      echo ${name}
      runHook preBuild

      mkdir -p build

      javac ${name} -d build

      echo "Main-Class: ${class}" > manifest.mf
      jar cmf manifest.mf java.jar -C build .

      runHook postBuild
    '';

    installPhase = ''
          runHook preInstall

          mkdir -p $out/share/java
          cp java.jar $out/share/java/

          mkdir -p $out/bin
          cat > $out/bin/java <<EOF
      #!/bin/sh
      exec ${pkgs.jdk}/bin/java -jar $out/share/java/java.jar "\$@"
      EOF
          chmod +x $out/bin/java

          runHook postInstall
    '';

    meta = {
      description = "A simple Hello World program in Java";
      mainProgram = "java";
    };
  }
