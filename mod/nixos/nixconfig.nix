{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  options.xfaf.nixconfig = {
    enable = lib.mkOption {
      description = "auto configure nix";
      type = lib.types.bool;
      default = true;
    };
    allowUnfree = lib.mkEnableOption "allow unfree packages";
    enableChannels = lib.mkEnableOption "enable channels";
    extraNixConfFile = lib.mkOption {
      description = "path to file to include in nix.conf";
      type = lib.types.nullOr lib.types.path;
      default = null;
    };
  };

  config =
    let
      cfg = config.xfaf.nixconfig;
    in
    {
      nixpkgs = {
        overlays = [
          inputs.nur.overlays.default
          outputs.overlays.default
        ];

        config.allowUnfree = cfg.allowUnfree;
      };

      nix =
        let
          flakeInputs = lib.filterAttrs (_: lib.isType "flake") (lib.removeAttrs inputs [ "self" ]);
        in
        {
          package = pkgs.nixVersions.latest;
          settings = {
            experimental-features = "nix-command flakes cgroups auto-allocate-uids pipe-operators";
            flake-registry = "";
            nix-path = config.nix.nixPath;
            auto-allocate-uids = true;
            use-cgroups = true;
            substituters = [ "https://attic.hhu-fscs.de/fscs-public" ];
            trusted-public-keys = [ "fscs-public:MuWSWnGgABFBwdeum/8n4rJxDpzYqhgd/Vm7u3fGMig=" ];
          };
          extraOptions = lib.optionalString (cfg.extraNixConfFile != null) "!include ${cfg.extraNixConfFile}";

          channel.enable = cfg.enableChannels;

          registry = (lib.mapAttrs (_: flake: { inherit flake; }) flakeInputs) // {
            xfaf-config.flake = inputs.self;
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
