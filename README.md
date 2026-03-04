# Crash

This program is intended to use to test errors/exceptions in [xinux-org/relago](https://github.com/xinux-org/relago)

## Getting Started

You can use it by adding your scripts to src/<c, java, python>. E.g. you want to use your Python script. Then you'll simply copy your script to src/python/<script>.py

### Example Usage

Bash:

```bash
$ ls src/c
segfault.c
$ nix run .#segfault
[1]    31760 segmentation fault (core dumped)  nix run .#segfault # Executed successfully
```

Nix:

```nix
# flake.nix
inputs.crash.url = "github:xinux-org/crash" # Firstly, we'll import our flake into our inputs.

# configuration.nix
imports =
    [
      inputs.crash.nixosModules.xinux-c-segfault # C
      inputs.crash.nixosModules.xinux-py-assertion # Python
      inputs.crash.nixosModules.xinux-java-internal # Java
    ]; # Here, we're importing exact module to use in our config.

  services.xinux-c-segfault.enable = true; # This enables xinux-c-segfault module in your configuration
  services.xinux-py-assertion.enable = true; # This enables xinux-py-segfault module in your configuration
  services.xinux-java-internal.enable = true; # This enables xinux-java-internal module in your configuration
```

## Reminder:

Always run with file name: `nix run .#filename`. But when you want to enable service, always add `xinux-<lang>-` prefix to your filename: `xinux-<lang>-<filename>`.
