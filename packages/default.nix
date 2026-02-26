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

  python = builtins.listToAttrs (map (x: {
      name = x;
      value = cp ./python {file = "${x}.py";};
    })
    pyFiles);

  result = python;
in
  result
