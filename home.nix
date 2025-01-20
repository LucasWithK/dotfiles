{ config, pkgs, ... }:

let
  username = "wsl";
  stateVersion = "25.05";

  homeDir = "/home/${username}";
  dotDir = "${homeDir}/.dotfiles";
in
{
  home.username = username;
  home.homeDirectory = homeDir;

  home.stateVersion = stateVersion;

  programs.home-manager.enable = true;

  home.packages = [
    pkgs.devenv
  ];

  xdg.enable = true;

  programs.fish = {
    enable = true;
    functions = {
      devenv-new = "mkdir $argv[1] && cd $argv[1] && devenv init";
    };
    shellInit = ''
      set fish_greeting
    '';
  };

  programs.bash = {
    enable = true;
    historyControl = ["ignoredups"];
    profileExtra = "exec fish";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zellij = {
    enable = true;
    settings = {
      default_shell = "fish";
      default_layout = "main";
      default_mode = "locked";
      mouse_mode = false;
      layout_dir = "${dotDir}/zellij";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      scan_timeout = 100;
    };
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
    extraPackages = [
      pkgs.nil
      pkgs.marksman
    ];
  };
}
