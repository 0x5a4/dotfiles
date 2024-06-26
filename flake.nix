{
  description = "0x5a4's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
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
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    nixos-hardware,
    sops-nix,
    home-manager,
    firefox-addons,
    stylix,
  }: let
    sharedModules = [
      sops-nix.nixosModules.sops
      stylix.nixosModules.stylix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.notuser = import ./nixos/home-manager/home.nix;
        home-manager.extraSpecialArgs = {inherit inputs;};
      }
    ];
  in {
    nixosConfigurations.fword = nixpkgs.lib.nixosSystem {
      modules =
        [
          ./nixos/fword
          nixos-hardware.nixosModules.framework-13th-gen-intel
        ]
        ++ sharedModules;
    };
  };
}
