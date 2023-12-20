{
  description = "0x5a4's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShell = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            rcm
            gnumake
            sops
            git
          ];
        };

        apps = rec {
          make = flake-utils.lib.mkApp {
            drv = pkgs.gnumake;
            exePath = "/bin/make";
          };
          default = make;
        };
      }
    );
}
