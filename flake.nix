{
  description = "0x5a4's nixos config. ein satz mit x, das war wohl nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";

    hardware.url = "github:NixOS/nixos-hardware/master";

    sops = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    betterfox.url = "github:HeitorAugustoLN/betterfox-nix";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-linux"
      "aarch64-darwin"
    ];

    lib = nixpkgs.lib;

    forAllSystems = lib.genAttrs systems;

    mkSystem = hostname: {
      "${hostname}" = lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./host/${hostname}];
      };
    };

    genSystems = hostnames:
      builtins.foldl' lib.trivial.mergeAttrs {} (builtins.map mkSystem hostnames);
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    overlays = import ./overlays.nix {inherit inputs;};

    nixosModules.xfaf = import ./mod/nixos;
    homeModules.xfaf = import ./mod/home-manager;

    nixosConfigurations = genSystems ["fword"];

    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          sops
          nixos-rebuild
        ];
      };
    });
  };
}
