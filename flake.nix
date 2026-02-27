{
  description = "C fucked and flaked";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    flake-parts,
    self,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} (top @ {
      pkgs,
      config,
      lib,
      ...
    }: {
      systems = [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      flake.nixosModules = import ./modules self {inherit pkgs config lib;};

      perSystem = {
        system,
        pkgs,
        lib,
        ...
      }: {
        packages = import ./packages {inherit pkgs inputs lib;};

        devShells.default = import ./shell.nix self {inherit pkgs;};
      };
    });
}
