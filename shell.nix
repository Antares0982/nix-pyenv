let
  pkgs = import <nixpkgs> { };
  # define version
  using_python = pkgs.python312;
  # import required python packages
  required_python_packages = import ./py_requirements.nix pkgs;
  #
  nix_pyenv_directory = ".nix-pyenv";
  pyenv = using_python.withPackages required_python_packages;
in
pkgs.mkShell {
  packages = [
    pyenv
  ];
  shellHook = ''
    cd ${builtins.toString ./.}

    if [[ ! -d ${nix_pyenv_directory} ]]; then mkdir ${nix_pyenv_directory}; fi
    if [[ ! -d ${nix_pyenv_directory}/lib ]]; then mkdir ${nix_pyenv_directory}/lib; fi
    if [[ ! -d ${nix_pyenv_directory}/bin ]]; then mkdir ${nix_pyenv_directory}/bin; fi

    ensure_symlink() {
        local link_path="$1"
        local target_path="$2"
        if [[ -L "$link_path" ]] && [[ "$(readlink "$link_path")" = "$target_path" ]]; then
            return 0
        fi
        rm -f "$link_path" > /dev/null 2>&1
        ln -s "$target_path" "$link_path"
    }

    for file in ${pyenv}/${using_python.sitePackages}/*; do
        ensure_symlink ${nix_pyenv_directory}/lib/$(basename $file) $file
    done
    for file in ${nix_pyenv_directory}/lib/*; do
        if [[ -L "$file" ]] && [[ "$(dirname $(readlink "$file"))" != "${pyenv}/${using_python.sitePackages}" ]]; then
            rm -f "$file"
        fi
    done
    ensure_symlink ${nix_pyenv_directory}/bin/python ${pyenv}/bin/python
    export PATH=${nix_pyenv_directory}/bin:$PATH
  '';
}
