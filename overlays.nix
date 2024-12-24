{ lib, ... }:
let
  mkPkgSets = pkgs: import ./pkgs { inherit lib pkgs; };
in
{
  vimPlugins =
    final: prev:
    let
      pkgSets = mkPkgSets prev;
    in
    {
      vimPlugins = prev.vimPlugins.extend (_: _: pkgSets.vimPlugins);
    };

  default =
    final: prev:
    let
      pkgSets = mkPkgSets prev;
    in
    lib.mergeAttrsList [
      pkgSets.extra
      pkgSets.scripts
    ];
}
