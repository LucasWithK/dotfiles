{ config, pkgs, ... }:
let
  username = "nixos";
  homeDir = "/home/${username}";
  dotDir = "${homeDir}/.dotfiles";
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

  home.packages = [
    # pkgs.name
  ];

  xdg.enable = true;

  programs.fish = {
    enable = true;
    functions = {
      dev-init = "nix flake init --template github:cachix/devenv && direnv allow && echo .direnv >> .gitignore";
      dev-new = "mkdir $argv[1] && cd $argv[1] && dev-init";
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
    enableFishIntegration = true;
    settings = {
      default_shell = "fish";
      default_layout = "main";
      default_mode = "locked";
      mouse_mode = false;
      layout_dir = "${dotDir}/zellij/layouts";
      theme_dir = "${dotDir}/zellij/themes";
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
