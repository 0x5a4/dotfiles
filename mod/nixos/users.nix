{
  lib,
  config,
  inputs,
  outputs,
  ...
}: {
  options.xfaf.users = let
    t = lib.types;
    userOpts = t.submodule {
      options = {
        opts = lib.mkOption {
          description = "options to pass to users.users.<username>";
          type = t.attrs;
          default = {};
        };

        home-manager = {
          enable = lib.mkEnableOption "enable home-manager for this user";
          config = lib.mkOption {
            description = "path to the users home.nix file";
            type = t.path;
          };
        };
      };
    };
  in
    lib.mkOption {
      type = t.attrsOf userOpts;
    };

  config = let
    opts = config.xfaf.users;
  in {
    users.users = lib.attrsets.mapAttrs (_: value:
      {
        isNormalUser = true;
      }
      // value.opts)
    opts;

    home-manager = let
      want-hm =
        lib.attrsets.filterAttrs (_: value: value.home-manager.enable) opts;
    in {
      useGlobalPkgs = true;
      extraSpecialArgs = {inherit inputs outputs;};
      users =
        lib.attrsets.mapAttrs (
          name: value: {...}: {
            home.username = name;
            home.homeDirectory = "/home/" + name;
            imports = [value.home-manager.config];
          }
        )
        want-hm;
    };
  };
}
