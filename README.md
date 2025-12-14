# .nix

My personal macOS and NixOS config

Clients
- **boook (macOS)**: Macbook Pro M1Pro. Standalone Home-Manager with Homebrew for casks
- **fork (NixOS)**: Framework 13 Ryzen AI 300. Full NixOS system with Home-Manager

## Install steps

### macOS (boook)

1. Install nix using the [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer)
```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```
> Restart the shell after installation

2. Add nix-community cache
```sh
nix run nixpkgs#cachix -- use nix-community
```

3. Install homebrew
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Disable analytics
/opt/homebrew/bin/brew analytics off
```

4. Clone config
```sh
git clone git@github.com:okkdev/dotnix.git
```

5. Symlink config
```sh
mkdir ~/.config
ln -s (pwd)/dotnix ~/.config/home-manager
```

6. Activate config
```sh
nix run home-manager -- switch
```

🚨 Fish needs to be added to `/etc/shells` manually:
```sh
echo $HOME/.nix-profile/bin/fish | sudo tee -a /etc/shells
chsh -s $HOME/.nix-profile/bin/fish
```

### NixOS (fork)

1. Install NixOS using the standard installer

2. Clone config
```sh
git clone git@github.com:okkdev/dotnix.git
cd dotnix
```

3. Build and activate
```sh
sudo nixos-rebuild switch --flake '.#fork'
```

## Apply new config

### macOS
```sh
home-manager switch
# or
nsw  # alias defined in config
```

### NixOS
```sh
sudo nixos-rebuild switch --flake '.#fork'
# or
nsw  # alias defined in config
```

## Update packages

```sh
nix flake update
home-manager switch
```

```sh
brew update
brew upgrade
```

## Troubleshooting

### Too many open files (macOS)

```sh
sudo launchctl limit maxfiles 1024 unlimited
sudo launchctl stop org.nixos.nix-daemon
sudo launchctl start org.nixos.nix-daemon
```

### Too many open files (NixOS)

```sh
ulimit -n 4096
```

Then retry your build command.

