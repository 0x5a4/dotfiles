{
  description = "0x5a4's nixos config. ein satz mit x, das war wohl nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    hardware.url = "github:NixOS/nixos-hardware/master";
    sops.url = "github:Mic92/sops-nix";
    nix-easyroam.url = "github:0x5a4/nix-easyroam";
    disko.url = "github:nix-community/disko";
    stylix.url = "github:danth/stylix";

    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager.url = "github:0x5a4/home-manager/init-wayfire";

    betterfox.url = "github:HeitorAugustoLN/betterfox-nix";

    # for nix flake init
    templates.url = "github:nixos/templates";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-on-droid,
      treefmt-nix,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      lib = nixpkgs.lib;

      eachSystem = f: lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});

      specialArgs = {
        inherit inputs outputs;
        xfaf-lib = import ./lib { inherit lib; };
      };
    in
    {
      formatter = eachSystem (
        (lib.flip treefmt-nix.lib.mkWrapper) {
          projectRootFile = "flake.nix";
          settings.on-unmatched = "debug";
          programs.nixfmt.enable = true;
        }
      );

      packages = eachSystem (pkgs: import ./pkgs pkgs);
      overlays = import ./overlays.nix { inherit inputs; };

      nixosModules.xfaf = import ./mod/nixos;
      homeModules.xfaf = import ./mod/home-manager;

      nixosConfigurations =
        lib.genAttrs
          [
            "fword"
            "yesmachine"
            "helmut"
          ]
          (
            hostname:
            lib.nixosSystem {
              modules = [ ./host/${hostname} ];
              inherit specialArgs;
            }
          );

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        modules = [ ./host/droid ];
        extraSpecialArgs = specialArgs;

        pkgs = import nixpkgs {
          system = "aarch64-linux";
          overlays = [ nix-on-droid.overlays.default ];
        };

        home-manager-path = home-manager.outPath;
      };

      devShells = eachSystem (pkgs: {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            sops
            nixos-rebuild
          ];
        };
      });

      checks = self.packages;
    };
}
