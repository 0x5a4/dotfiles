{ inputs, ... }:
{
  imports = [
    ./services
    ./bootconfig.nix
    ./nixconfig.nix
    ./users.nix
    ./sudo.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.sops.nixosModules.sops
    inputs.stylix.nixosModules.stylix
    inputs.disko.nixosModules.disko
    inputs.nix-easyroam.nixosModules.nix-easyroam
  ];
}
