{
  lib,
  pkgs ? import <nixpkgs> { },
  persist ? false,
  mkShell,
}:
let
  optionalAttrs = lib.attrsets.optionalAttrs;
  # define the nix-pyenv directory
  nix-pyenv-directory = ".nix-pyenv";
  # define version
  usingPython = pkgs.python313;
  # import required python packages
  requiredPythonPackages = pkgs.callPackage ./py_requirements.nix { };
  # create python environment
  pyenv = usingPython.withPackages requiredPythonPackages;
  #
  callShellHookParam = {
    inherit
      nix-pyenv-directory
      pyenv
      usingPython
      persist
      pkgs
      ;
  };
  internalShell = mkShell (
    {
      packages = [ pyenv ];
    }
    // (optionalAttrs (!persist) {
      shellHook = pkgs.callPackage ./shellhook.nix callShellHookParam;
    })
  );
in
internalShell.overrideAttrs (
  optionalAttrs persist {
    shellHook = pkgs.callPackage ./shellhook.nix (
      callShellHookParam
      // {
        inherit (internalShell) inputDerivation;
      }
    );
  }
)
