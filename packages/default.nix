{
  pkgs,
  lib,
  ...
}: let
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

  helperAttr = x: {
    name = x;
    value = pkgs.callPackage ./python/default.nix {file = "/${x}.py";};
  };

  srcFiles = builtins.map (x: pkgs.lib.strings.removeSuffix ".py" x.name) (builtins.filter (x: x.value == "regular") (pkgs.lib.attrsToList (builtins.readDir ../src/python)));
  # nixFiles = builtins.map (x: pkgs.lib.concatStrings [x ".nix"]) srcFiles;
  attrList =
    builtins.map helperAttr
    srcFiles;

  attrSet = builtins.listToAttrs attrList;
in
  attrSet
# {
#   # Javas
#   internal = gf "j" /internal.nix;
#   outOfMemory = gf "j" /outOfMemory.nix;
#   stackOverflow = gf "j" /stackOverflow.nix;
#   unknown = gf "j" /unknown.nix;
#   # Pythons
#   assertion = gf "p" /assertion.nix;
#   # c-crash = pkgs.callPackage ./c-crash.nix {inherit pkgs;};
#   # py = pkgs.callPackage ./py.nix {inherit pkgs;};
# }

