{inputs, ...}: {
  imports = [
    ./services
    ./bootconfig.nix
    ./nixconfig.nix
    ./users.nix

    inputs.hm.nixosModules.home-manager
    inputs.nix-index-database.nixosModules.nix-index
    inputs.sops.nixosModules.sops
    inputs.stylix.nixosModules.stylix
    inputs.disko.nixosModules.disko
  ];
}
