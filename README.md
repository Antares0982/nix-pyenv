# nix-pyenv
Nix Python workspace template for modern IDEs, without virtualenv

### Prerequsite

Install `direnv`

### Usage

* Copy all these files to your workspace
* Add requirements in `py_requirements.nix`. Modify python version in `shell.nix`
* Enable `direnv` for your workspace (using `direnv allow .`)
* run `nix-shell` to generate the symlinks

#### VSCode

* Enable [direnv](https://github.com/direnv/direnv-vscode) plugin
* Choose correct python interpreter

