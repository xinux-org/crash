{pkgs, ...}: let
  javaDir = ./java;
  pyDir = ./python;
  cDir = ./c;

  gf = m: f:
    pkgs.callPackage (
      (
        if m == "j"
        then javaDir
        else if m == "p"
        then pyDir
        else if m == "c"
        then cDir
        else abort "Invalid value"
      )
      + f
    ) {inherit pkgs;};
in {
  # Javas
  internal = gf "j" /internal.nix;
  outOfMemory = gf "j" /outOfMemory.nix;
  stackOverflow = gf "j" /stackOverflow.nix;
  unknown = gf "j" /unknown.nix;

  # c-crash = pkgs.callPackage ./c-crash.nix {inherit pkgs;};
  # py = pkgs.callPackage ./py.nix {inherit pkgs;};
}
