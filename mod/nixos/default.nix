{inputs, ...}: {
  imports = [
    ./services
    ./bootconfig.nix
    ./nixconfig.nix
    ./users.nix

    inputs.home-manager.nixosModules.home-manager
    inputs.sops.nixosModules.sops
    inputs.stylix.nixosModules.stylix
    inputs.disko.nixosModules.disko
  ];
}
