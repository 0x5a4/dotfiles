{
  description = "0x5a4's nixos config. ein satz mit x, das war wohl nix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    hardware.url = "github:NixOS/nixos-hardware/master";
    sops-nix.url = "github:Mic92/sops-nix";
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

    home-manager.url = "github:nix-community/home-manager";
    betterfox.url = "github:HeitorAugustoLN/betterfox-nix";
    nixvim.url = "github:nix-community/nixvim";
    nixcord.url = "github:KaylorBen/nixcord";

    # for nix flake init
    templates.url = "github:nixos/templates";

    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nix-on-droid,
      sops-nix,
      nixvim,
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

      lib = nixpkgs.lib.extend (
        final: prev: {
          xfaf = import ./lib { lib = prev; };
        }
      );

      eachSystem = f: lib.genAttrs systems (system: f system nixpkgs.legacyPackages.${system});

      specialArgs = {
        inherit inputs outputs lib;
      };

      nixvimModuleFor = pkgs: {
        inherit pkgs;
        module = import ./mod/nixvim;
        extraSpecialArgs = specialArgs // {
          lib = lib.extend nixvim.lib.overlay;
        };
      };
    in
    {
      formatter = eachSystem (
        system: pkgs:
        pkgs.writers.writeBashBin "fmt" ''
          find . -type f -name \*.nix | xargs ${lib.getExe pkgs.nixfmt-rfc-style}
        ''
      );

      packages = eachSystem (
        system: pkgs:
        {
          nixvim = nixvim.legacyPackages.${system}.makeNixvimWithModule (nixvimModuleFor pkgs);
        }
        // (import ./pkgs { inherit pkgs lib; }).allPackages
      );

      overlays = import ./overlays.nix { inherit lib; };

      nixosModules.xfaf = import ./mod/nixos;
      homeModules.xfaf = import ./mod/home-manager;

      nixosConfigurations =
        lib.genAttrs
          [
            "fword"
            "yesmachine"
          ]
          (
            hostname:
            lib.nixosSystem {
              modules = [ ./hosts/${hostname} ];
              inherit specialArgs;
            }
          );

      nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
        modules = [ ./hosts/droid ];
        extraSpecialArgs = specialArgs;

        pkgs = import nixpkgs {
          system = "aarch64-linux";
          overlays = [ nix-on-droid.overlays.default ];
        };

        home-manager-path = home-manager.outPath;
      };

      devShells = eachSystem (
        system: pkgs: {
          default = pkgs.mkShell {
            sopsPGPKeyDirs = [
              "${toString ./.}/hosts/keys/"
            ];

            nativeBuildInputs = with pkgs; [
              sops
              nixos-rebuild
              sops-nix.packages.${system}.sops-import-keys-hook
            ];
          };
        }
      );

      checks = eachSystem (
        system: pkgs:
        {
          nixvim-config = nixvim.lib.${system}.check.mkTestDerivationFromNixvimModule (nixvimModuleFor pkgs);
        }
        // (import ./pkgs { inherit pkgs lib; }).allPackages
      );
    };
}
