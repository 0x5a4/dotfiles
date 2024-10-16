{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.flake-programs-sqlite.nixosModules.programs-sqlite
  ];

  options.xfaf.nixconfig = {
    enable = lib.mkOption {
      description = "auto configure nix";
      type = lib.type.bool;
      default = true;
    };
    allowUnfree = lib.mkEnableOption "allow unfree packages";
    enableChannels = lib.mkEnableOption "enable channels";
  };

  config = let
    opts = config.xfaf.nixconfig;
  in {
    nixpkgs = {
      overlays = let
        myOverlays =
          if (outputs ? "overlays")
          then (builtins.attrValues outputs.overlays)
          else [];
      in
        myOverlays
        ++ [
          inputs.nur.overlay
        ];

      config.allowUnfree = opts.allowUnfree;
    };

    nix = let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
    in {
      package = pkgs.nixVersions.latest;
      settings = {
        experimental-features = "nix-command flakes cgroups auto-allocate-uids";
        flake-registry = "";
        nix-path = config.nix.nixPath;
      };
      channel.enable = opts.enableChannels;

      registry =
        (lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs)
        // {
          np.flake = flakeInputs.nixpkgs;
        };
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

    programs.nh.enable = true;

    environment.systemPackages = with pkgs; [
      hydra-check
      nix-output-monitor
      nixpkgs-review
      nix-update
    ];
  };
}
