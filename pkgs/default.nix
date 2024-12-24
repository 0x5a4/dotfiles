{ pkgs, lib }:
let
  pkgNames =
    path:
    builtins.readDir path
    |> lib.filterAttrs (n: v: v == "regular")
    |> lib.attrNames
    |> lib.filter (lib.hasSuffix ".nix")
    |> lib.map (lib.removeSuffix ".nix");

  buildPkgs = path: lib.genAttrs (pkgNames path) (name: pkgs.callPackage "${path}/${name}.nix" { });

  pkgSets =
    builtins.readDir ./.
    |> lib.filterAttrs (n: v: v == "directory")
    |> lib.attrNames
    |> (lib.flip lib.genAttrs) (path: buildPkgs ./${path});

  allPackages = lib.attrValues pkgSets |> lib.mergeAttrsList;
in
pkgSets // { inherit allPackages; }
