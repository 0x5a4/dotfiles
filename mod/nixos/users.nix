{
  lib,
  config,
  specialArgs,
  inputs,
  outputs,
  ...
}:
{
  options.xfaf.users =
    let
      t = lib.types;
      userOpts = t.submodule {
        options = {
          opts = lib.mkOption {
            description = "options to pass to users.users.<username>";
            type = t.attrs;
            default = { };
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
      default = { };
    };

  config =
    let
      opts = config.xfaf.users;
    in
    {
      users.users = lib.mapAttrs (_: value: value.opts // { isNormalUser = true; }) opts;

      home-manager =
        let
          want-hm = lib.filterAttrs (_: value: value.home-manager.enable) opts;
        in
        {
          extraSpecialArgs = lib.removeAttrs specialArgs [ "lib" ];
          users = lib.mapAttrs (
            name: value:
            { ... }:
            {
              home.username = name;
              home.homeDirectory = "/home/" + name;
              imports = [ value.home-manager.config ];

              nixpkgs = {
                overlays = [
                  inputs.nur.overlays.default
                  outputs.overlays.default
                ];

                config = {
                  inherit (config.xfaf.nixconfig) allowUnfree;
                };
              };
            }
          ) want-hm;
        };
    };
}
