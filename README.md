# dotfiles

My dotfiles (for Debian on WSL).

## Setup
- Initial updates and installs:
```bash
sudo apt update -y && sudo apt upgrade -y && sudo apt install curl xz-utils openssh-client -y
```

- Enable systemd and disable windows path interop in WSL:
```bash
printf "[boot]\nsystemd=true\n[interop]\nappendWindowsPath = false\n" | sudo tee /etc/wsl.conf
```

- Restart WSL in windows.

- Install nix (just accept everything):
```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

- Add user to trusted users:
```bash
printf "\ntrusted-users = root $USER\n" | sudo tee -a /etc/nix/nix.conf
```

- Restart the nix-daemon:
```bash
sudo systemctl restart nix-daemon
```

- Add unstable nixpkgs nix-channel:
```bash
nix-channel --add https://channels.nixos.org/nixpkgs-unstable nixpkgs
```

- Add home-manager nix-channel and install it:
```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && nix-channel --update && nix-shell '<home-manager>' -A install
```

- Download dotfiles repository:
```bash
nix-shell -p git --run "git clone https://github.com/IllusionaryFrog/dotfiles.git ~/.dotfiles"
```

- Adjust configuration options in `home.nix` (like `username`) and update git url in `.git/config` to:
```
git@illusionaryfrog.github.com:IllusionaryFrog/dotfiles.git
```

- Switch to the new home-manager config:
```bash
home-manager switch -f ~/.dotfiles/home.nix -b old
```

- Add two ssh identity files for both accounts (see `ssh/config` and `git/`).

- Restart WSL in windows and done.

## Usage
- Update home-manager config:
```bash
home-manager switch -f ~/.dotfiles/home.nix
```

- Update home-manager and nixpkgs nix-channel:
```bash
nix-channel --update
```

- Remember to bump `stateVersion` in `home.nix`.
