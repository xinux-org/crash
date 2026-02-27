flake: {
  pkgs,
  config,
  lib,
}: let
  la = builtins.listToAttrs;

  pyFiles = map (x: lib.strings.removeSuffix ".py" x.name) (builtins.filter (x: x.value == "regular") (lib.attrsToList (builtins.readDir ../src/python)));

  python = la (map (x: {
      name = x;
      value = import ./python flake {
        pkg = x;
      };
    })
    pyFiles);

  javaFiles = map (x: lib.strings.removeSuffix ".java" x.name) (builtins.filter (x: x.value == "regular") (lib.attrsToList (builtins.readDir ../src/java)));

  java = la (map (x: {
      name = lib.strings.toLower x;
      value = import ./java flake {pkg = lib.strings.toLower x;};
    })
    javaFiles);

  result = python // java;
in
  result
