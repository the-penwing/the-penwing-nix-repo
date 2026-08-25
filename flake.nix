{
  description = "the-penwing package repository";
  nixConfig = {
    extra-substituters = ["https://the-penwing.cachix.org"];
    extra-trusted-public-keys = ["the-penwing.cachix.org-1:b1OsSQhQU/bhmwDiMuStEovsvUIzVPYVfZt289btWAg="];
  };
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
      };
      flake = {
        overlays.default = final: prev: import ./pkgs {pkgs = final;};
      };
    };
}
