# dotfiles

My dotfiles (for Debian on WSL).

## Setup
- Initial updates and installs:
```bash
sudo apt-get upgrade && sudo apt-get update -y && sudo apt-get install curl xz-utils openssh-client -y
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

- Add two ssh identity files for both accounts (see `ssh/config` and `git/`).

- Switch to the new home-manager config:
```bash
home-manager switch -f ~/.dotfiles/home.nix -b old
```

- Restart WSL in windows and done.

## Usage
- Update home-manager config:
```bash
home-manager switch -f ~/.dotfiles/home.nix
```

- Update home-manager channel:
```bash
nix-channel --update
```
