{
  pkgs,
  lib ? pkgs.lib,
}: let
  isPkgFile = name: type:
    type == "regular" && lib.hasSuffix ".nix" name && name != "default.nix";
  pkgFiles = lib.filterAttrs isPkgFile (builtins.readDir ./.);
  names = map (lib.removeSuffix ".nix") (builtins.attrNames pkgFiles);
in
  lib.genAttrs names (name: pkgs.callPackage (./. + "/${name}.nix") {})
