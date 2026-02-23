flake: {
  java = import ./java.nix flake;
  c-crash = import ./c-crash.nix flake;
  py = import ./py.nix flake;
}
