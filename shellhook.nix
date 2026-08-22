{
  pkgs,
  callPackage,
  nix,
  nix-pyenv-directory,
  pyenv,
  usingPython,
  inputDerivation ? "",
  ...
}:
let
  sitePackagesString = usingPython.sitePackages;
  nixPyenv = callPackage ./nix-pyenv.nix { inherit pyenv sitePackagesString inputDerivation; };
  # plain string, so it is not copied into the store again
  nixpkgsPath = toString pkgs.path;
in
''
  ${nix}/bin/nix-store --add-root ./${nix-pyenv-directory} --realise ${nixPyenv}
''
+ pkgs.lib.optionalString (pkgs.lib.hasPrefix builtins.storeDir nixpkgsPath) ''
  ${nix}/bin/nix-store --add-root ./${nix-pyenv-directory}-nixpkgs --realise ${nixpkgsPath}
''
