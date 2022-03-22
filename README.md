# .nix

My personal macOS Home-Manager config

Manages dotfiles and cli tools via Home-Manager/Nix and casks via Homebrew

# Install steps

1. Install nix
```sh
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon
```
1. Add unstable channel 
```sh
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
```
1. Install home manager
```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```
1. Install homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
1. Clone config
```sh
git clone git@github.com:okkdev/dotnix.git
```
1. Symlink config
```sh
ln -s dotnix/ ~/.config/nixpkgs
```
1. Activate config
```sh
home-manager switch
```
