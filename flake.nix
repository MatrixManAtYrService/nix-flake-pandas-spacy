{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
  };


  outputs = { self, nixpkgs, flake-utils }: (flake-utils.lib.eachSystem [
    "x86_64-linux"
    "x86_64-darwin"
    "aarch64-linux"
    "aarch64-darwin"
  ] (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    rec {
      packages.turbulence = pkgs.poetry2nix.mkPoetryApplication {
        projectDir = ./.;
      };

      defaultPackage= packages.myawesomepackage;

      devShell = pkgs.mkShell {
        buildInputs = [
          pkgs.poetry
          pkgs.python310Packages.pandas
          pkgs.python310Packages.spacy
        ];
      };
    }));
}
