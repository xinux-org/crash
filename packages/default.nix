{
  pkgs,
  lib,
  ...
}: let
  cp = pkgs.callPackage;

  pyFiles = [
    "assertion"
    "attribute"
    "blockingio"
    "brokenpipe"
    "childprocess"
    "connection"
    "environment"
    "fileexists"
    "filenotfound"
    "floatingpoint"
    "generatorexit"
    "import"
    "indentation"
    "io"
    "isadirectory"
    "key"
    "keyboardinterrupt"
    "memory"
    "modulenotfound"
    "name"
    "notadirectory"
    "notimplemented"
    "os"
    "overflow"
    "permission"
    "processlookup"
    "pythonfinalization"
    "recursion"
    "reference"
    "runtime"
    "stopasynciteration"
    "stopiteration"
    "syntax"
    "system"
    "systemexit"
    "tab"
    "timeout"
    "type"
    "unboundlocal"
    "unicode"
    "value"
    "zerodivision"
  ];

  javaFiles = [
    "Internal"
    "OutOfMemory"
    "StackOverflow"
    "Unknown"
  ];

  python = builtins.listToAttrs (map (x: {
      name = x;
      value = cp ./python {file = "${x}.py";};
    })
    pyFiles);

  java = builtins.listToAttrs (map (x: {
      name = lib.strings.toLower x;
      value = cp ./java {file = "${x}.java";};
    })
    javaFiles);

  result = python // java;
in
  result
