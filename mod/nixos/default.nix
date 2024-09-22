{inputs, ...}: {
  imports = [
    ./services
    ./bootconfig.nix
    ./nixconfig.nix
    ./users.nix

    inputs.hm.nixosModules.home-manager
    inputs.sops.nixosModules.sops
    inputs.stylix.nixosModules.stylix
    inputs.disko.nixosModules.disko
  ];
}
