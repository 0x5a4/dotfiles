{
  description = "Ein Satz mit X";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    sops-nix,
    home-manager,
    firefox-addons,
  }: let
    sharedModules = [
      sops-nix.nixosModules.sops
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.notuser = import ./home-manager/home.nix;
        home-manager.extraSpecialArgs = {inherit inputs;};
      }
    ];
  in {
    nixosConfigurations.t420 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          ./t420
          nixos-hardware.nixosModules.lenovo-thinkpad-t420
        ]
        ++ sharedModules;
    };

    nixosConfigurations.fword = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules =
        [
          ./fword
          nixos-hardware.nixosModules.framework-13th-gen-intel
        ]
        ++ sharedModules;
    };
  };
}
