# .nix

My macOS Home-Manager config

Manages dotfiles and cli tools via Home-Manager/Nix and casks via Homebrew

# Install steps

1. Install nix
```sh
sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume --daemon
```
2. Install home manager
```sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```
3. Install homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
4. Clone config
```sh
git clone git@github.com:okkdev/dotnix.git
```
5. Symlink config
```sh
ln -s dotnix/ ~/.config/nixpkgs
```
6. Activate config
```sh
home-manager switch
```
