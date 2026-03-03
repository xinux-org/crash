file: {pkgs}: let
  path = ../../src/c;

  name = "${file.name}.c";
in
  pkgs.stdenv.mkDerivation {
    pname = name;
    version = "0.0.1";

    src = path;

    nativeBuildInputs = with pkgs; [
      cmake
      llvmPackages.llvm
      llvmPackages.clang-tools
    ];

    buildPhase = ''
      gcc ${path}/${name} -o main
    '';

    installPhase = ''
      mkdir -p $out/bin
      cp main $out/bin/main
    '';

    meta.mainProgram = "main";
  }
