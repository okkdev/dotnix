# .nix

My personal macOS Home-Manager config

Manages dotfiles and cli tools via Home-Manager/Nix and casks via Homebrew

# Install steps

1. Install nix using the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer)
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
2. Install homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Disable analytics
brew analytics off
```
3. Clone config
```sh
git clone git@github.com:okkdev/dotnix.git
```
4. Symlink config
```sh
mkdir ~/.config
ln -s (pwd)/dotnix ~/.config/home-manager
```
5. Get Flake dependencies
```sh
cd dotnix
nix flake archive
# or
nix flake update # to also update
```
6. Activate config
```sh
nix run home-manager -- switch
```

⚠️  Subsequent runs of home-manager are as simple as
```sh
home-manager switch
```

🚨 Fish needs to be added to `/etc/shells` manually:
```sh
sudo echo /Users/js/.nix-profile/bin/fish >> /etc/shells
chsh -s /Users/js/.nix-profile/bin/fish
```
