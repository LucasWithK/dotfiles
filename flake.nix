{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, treefmt-nix, ... } @ inputs:
    let
      systems = [ "x86_64-linux" ];

      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });

      templates = builtins.attrNames (builtins.readDir ./templates);

      treefmtEval = forAllSystems ({ pkgs }: treefmt-nix.lib.evalModule pkgs {
        projectRootFile = "flake.nix";
        programs.nixpkgs-fmt.enable = true;
        # Add formatter for files that should be formatted
      });
    in
    {
      templates = nixpkgs.lib.genAttrs templates (template: {
        description = "The ${template} template";
        path = ./templates/${template};
      });

      # For `nix fmt` (format every file that has a formatter)
      formatter = forAllSystems ({ pkgs }: treefmtEval.${pkgs.system}.config.build.wrapper);

      # For `nix flake check` (to validate that the project's code is properly formatted)
      checks = forAllSystems ({ pkgs }: {
        formatting = treefmtEval.${pkgs.system}.config.build.check self;
      });
    };
}
