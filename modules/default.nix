flake: {
  pkgs,
  config,
  lib,
}: let
  la = builtins.listToAttrs;

  pyFiles = map (x: lib.strings.removeSuffix ".py" x.name) (builtins.filter (x: x.value == "regular" && lib.strings.hasSuffix ".py" x.name) (lib.attrsToList (builtins.readDir ../src/python)));

  python = la (map (x: {
      name = "py-${x}";
      value = import ./python flake {
        pkg = x;
      };
    })
    pyFiles);

  javaFiles = map (x: lib.strings.removeSuffix ".java" x.name) (builtins.filter (x: x.value == "regular" && lib.strings.hasSuffix ".java" x.name) (lib.attrsToList (builtins.readDir ../src/java)));

  java = la (map (x: {
      name = lib.strings.toLower "java-${x}";
      value = import ./java flake {pkg = lib.strings.toLower x;};
    })
    javaFiles);

  cFiles = map (x: lib.strings.removeSuffix ".c" x.name) (builtins.filter (x: x.value == "regular" && lib.strings.hasSuffix ".c" x.name) (lib.attrsToList (builtins.readDir ../src/c)));

  c = la (map (x: {
      name = lib.strings.toLower "c-${x}";
      value = import ./c flake {pkg = lib.strings.toLower x;};
    })
    cFiles);

  result = python // java // c;
in
  result
