{pkgs, ...}: {
  java = pkgs.callPackage ./java.nix {inherit pkgs;};
  c-crash = pkgs.callPackage ./c-crash.nix {inherit pkgs;};
  py = pkgs.callPackage ./py.nix {inherit pkgs;};
}
