# nix-pyenv
A very simple Python workspace template for Nix users with modern IDEs, without virtualenv

### Prerequsite

Install `direnv` (optional)

### Usage

* Copy all these files to your workspace
* Add requirements in `py_requirements.nix`. Modify python version in `shell.nix`
* Enable `direnv` for your workspace (using `direnv allow .`) (optional)
* run `nix-shell` to generate the symlinks

The shell hook registers two gc roots: `.nix-pyenv` (the environment) and
`.nix-pyenv-nixpkgs` (the nixpkgs source), so `nix-collect-garbage` never forces
a re-download of nixpkgs. Both are refreshed on every shell entry, so an old
nixpkgs becomes collectable again after you update the lock.

#### VSCode

* Enable [direnv](https://github.com/direnv/direnv-vscode) plugin (optional)
* Choose correct python interpreter

