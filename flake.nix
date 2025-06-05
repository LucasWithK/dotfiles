{
  inputs.nixpkgs.url = "nixpkgs/nixpkgs-unstable";

  outputs = { nixpkgs, ... } @ inputs:
    let
      systems = [ "x86_64-linux" ];

      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });

      templates = builtins.attrNames (builtins.readDir ./templates);
    in
    {
      templates = nixpkgs.lib.genAttrs templates (template: {
        description = "The ${template} template";
        path = ./templates/${template};
      });
    };
}
