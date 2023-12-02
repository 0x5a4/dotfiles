{
  description = "Ein Satz mit X";

  outputs = {
    self,
    nixpkgs,
  }: {
    nixosConfigurations.t420 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [./t420];
    };
  };
}
