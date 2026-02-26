{
  pkgs,
  file,
}: let
  path = ../../src/c;
in
  pkgs.llvmPackages.stdenv.mkDerivation {
    pname = file;
    version = "0.0.1";

    src = path;

    nativeBuildInputs = with pkgs; [
      cmake
      llvmPackages.llvm
      llvmPackages.clang-tools
    ];

    installPhase = ''
      ls -la .
    '';

    cmakeFlags = [
      "-DENABLE_TESTING=OFF"
      "-DENABLE_INSTALL=ON"
    ];
  }
