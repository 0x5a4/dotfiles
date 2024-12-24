{
  xfaf-lib,
  inputs,
  ...
}:
{
  imports = (xfaf-lib.importAllChildren ./.) ++ [
    inputs.home-manager.nixosModules.home-manager
    inputs.sops.nixosModules.sops
    inputs.stylix.nixosModules.stylix
    inputs.disko.nixosModules.disko
    inputs.nix-easyroam.nixosModules.nix-easyroam
  ];
}
