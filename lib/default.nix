{ lib, ... }@args:
{
  disko = import ./disko.nix args;
  nixvim = import ./nixvim.nix args;

  importAllChildren =
    path:
    builtins.readDir path
    |> lib.filterAttrs (n: v: v == "directory" || (v == "regular" && lib.hasSuffix ".nix" n))
    |> lib.attrNames
    |> lib.remove "default.nix"
    |> lib.map (name: "${path}/${name}");
}
