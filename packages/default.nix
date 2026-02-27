{
  pkgs,
  lib,
  ...
}: let
  cp = pkgs.callPackage;

  la = builtins.listToAttrs;

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

  cFiles = [
    "will_abort"
    "will_segfault"
    "will_segfault_in_new_pid"
    "will_segfault_threads"
    "will_stackoverflow"
  ];

  c = la (map (x: {
      name = x;
      value = cp ./c {file = "${x}.c";};
    })
    cFiles);

  python = la (map (x: {
      name = x;
      value = cp ./python {file = "${x}.py";};
    })
    pyFiles);

  java = la (map (x: {
      name = lib.strings.toLower x;
      value = cp ./java {file = "${x}.java";};
    })
    javaFiles);

  result = python // java // c;
in
  result
