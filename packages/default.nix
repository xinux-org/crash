{
  pkgs,
  lib,
  ...
}: let
  cp = pkgs.callPackage;

  la = builtins.listToAttrs;

  pyFiles = map (x: lib.strings.removeSuffix ".py" x.name) (builtins.filter (x: x.value == "regular" && lib.strings.hasSuffix ".py" x.name) (lib.attrsToList (builtins.readDir ../src/python)));

  python = la (map (x: {
      value = cp ./python {name = x;} {inherit pkgs;};
      name = x;
    })
    pyFiles);

  javaFiles = map (x: lib.strings.removeSuffix ".java" x.name) (builtins.filter (x: x.value == "regular" && lib.strings.hasSuffix ".java" x.name) (lib.attrsToList (builtins.readDir ../src/java)));

  java = la (map (x: {
      value = cp ./java {name = x;} {inherit pkgs;};
      name = lib.strings.toLower x;
    })
    javaFiles);

  cFiles = map (x: lib.strings.removeSuffix ".c" x.name) (builtins.filter (x: x.value == "regular" && lib.strings.hasSuffix ".c" x.name) (lib.attrsToList (builtins.readDir ../src/c)));

  c = la (map (x: {
      value = cp ./c {name = x;} {inherit pkgs;};
      name = x;
    })
    cFiles);

  result = python // java // c;
in
  result
