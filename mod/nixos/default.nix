{
  lib,
  inputs,
  ...
}:
{
  imports = (lib.xfaf.importAllChildren ./.) ++ [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops-nix.nixosModules.sops
    inputs.stylix.nixosModules.stylix
    inputs.disko.nixosModules.disko
    inputs.nix-easyroam.nixosModules.nix-easyroam
  ];
}
