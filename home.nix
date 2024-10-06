{ config, pkgs, ... }:
let
  username = "nixos";
  homeDir = "/home/${username}";
  dotDir = "${homeDir}/dotfiles";
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = username;
  home.homeDirectory = homeDir;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bash = {
    enable = true;
    historyControl = ["ignoredups"];
  };

  programs.ssh = {
    enable = true;
    extraConfig = builtins.readFile ./ssh/config;
  };

  programs.git = {
    enable = true;
    extraConfig.init.defaultBranch = "main";
    includes = [
      { condition = "hasconfig:remote.*.url:git@illusionaryfrog.github.com:*/**"; path = "${dotDir}/git/illusionaryfrog"; }
      { condition = "hasconfig:remote.*.url:git@lukashassler.github.com:*/**"; path = "${dotDir}/git/lukashassler"; }
    ];
  };

  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor.line-number = "relative";
    };
  };
}
