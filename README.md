# dotfiles

My dotfiles for nixos WSL installation

## Initial Setup
- Enable the experimental flakes feature by adding the following line to `/etc/nixos/configuration.nix`:
```nix
nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

- Rebuild with:
```bash
sudo nixos-rebuild switch
```

- Clone the repository using:
```bash
nix-shell -p git --run "git clone https://github.com/IllusionaryFrog/dotfiles.git ~/.dotfiles"
```

- Add two ssh identity files for both account names (see `ssh/config` and `git/{name}`) and add them to github.

- Create an owned gc folder for the user with:
```bash
sudo mkdir -p /nix/var/nix/gcroots/per-user/$USER && sudo chown $USER /nix/var/nix/gcroots/per-user/$USER
```

- Rebuild again, now using:
```bash
sudo nixos-rebuild switch --flake ~/.dotfiles
```

- Replace the `url` in `~/.dotfiles/.git/config` with:
```
git@illusionaryfrog.github.com:IllusionaryFrog/dotfiles.git
```

- Done!

# Info
- Use `devenv-init` inside a folder to create a basic dev environment.
