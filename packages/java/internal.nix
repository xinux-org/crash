{pkgs}:
pkgs.stdenv.mkDerivation rec {
  pname = "internal";
  version = "1.0.0";

  src = ../../src/java;

  nativeBuildInputs = [pkgs.jdk];

  buildInputs = [pkgs.jdk];

  dontUnpack = false;

  buildPhase = ''
    runHook preBuild

    mkdir -p build

    javac Internal.java -d build

    echo "Main-Class: Internal" > manifest.mf
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
