# nix-pyenv
A very simple Python workspace template for Nix users with modern IDEs, without virtualenv

### Prerequsite

Install `direnv` (optional)

### Usage

* Copy all these files to your workspace
* Add requirements in `py_requirements.nix`. Modify python version in `shell.nix`
* Enable `direnv` for your workspace (using `direnv allow .`) (optional)
* run `nix-shell` to generate the symlinks
* pass `persist = true;` to `shell.nix` if you want a shell env that will not be GCed as long as the `.nix-pyenv` directory still exists

#### VSCode

* Enable [direnv](https://github.com/direnv/direnv-vscode) plugin (optional)
* Choose correct python interpreter

