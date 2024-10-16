# dotfiles

My dotfiles for nixos WSL installation

## Initial Setup
- Enable the experimental flakes feature by adding the line `nix.settings.experimental-features = [ "nix-command" "flakes" ];` to `/etc/nixos/configuration.nix`
- Rebuild using `sudo nixos-rebuild switch`
- Clone the repository using `nix-shell -p git --run "git clone https://github.com/IllusionaryFrog/dotfiles.git ~/.dotfiles"`
- Add two ssh identity files for both account names (see `ssh/config` and `git/{name}`) and add them to github
- Create a owned gc folder for the user using `sudo mkdir -p /nix/var/nix/gcroots/per-user/$USER && sudo chown $USER /nix/var/nix/gcroots/per-user/$USER`
- Rebuild again using `sudo nixos-rebuild switch --flake ~/.dotfiles`
- Replace the `url` in `~/.dotfiles/.git/config` with `git@illusionaryfrog.github.com:IllusionaryFrog/dotfiles.git`
- Done
