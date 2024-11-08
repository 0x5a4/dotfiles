{
  lib,
  config,
  ...
}:
{
  options.xfaf.services.wifi =
    let
      t = lib.types;
    in
    {
      enable = lib.mkEnableOption "enable wifi services configuration";

      secretsFile = lib.mkOption {
        type = t.path;
        description = "path to the sops secret file used for passwords";
      };

      networks = lib.mkOption {
        type = t.attrsOf (t.either t.str t.attrs);
        description = "map from network ssids to either their password env name or an attrset that will be used as is";
      };
    };

  config =
    let
      opts = config.xfaf.services.wifi;
    in
    lib.mkIf opts.enable {
      sops.secrets.wifi = {
        sopsFile = opts.secretsFile;
        format = "binary";
      };

      networking.wireless = {
        enable = true;
        userControlled.enable = true;
        secretsFile = config.sops.secrets.wifi.path;

        networks =
          let
            mkNetwork =
              ssid: network_cfg:
              if builtins.isString network_cfg then
                {
                  pskRaw = "ext:${network_cfg}";
                }
              else
                network_cfg;
          in
          lib.attrsets.mapAttrs mkNetwork opts.networks;
      };
    };
}
