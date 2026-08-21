{
  description = "penwing systems package repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = {
        pkgs,
        system,
        ...
      }: {
        packages = import ./pkgs {inherit pkgs;};
        legacyPackages = pkgs;
      };
      flake = {
        overlays.default = final: prev: import ./pkgs {pkgs = final;};
        nixosModules = import ./modules;
      };
    };
}
