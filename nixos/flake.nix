{
  description = "Ein Satz mit X";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    sops-nix,
  }: {
    nixosConfigurations.t420 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./t420
        nixos-hardware.nixosModules.lenovo-thinkpad-t420
        sops-nix.nixosModules.sops
      ];
    };
  };
}
