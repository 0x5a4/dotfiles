{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.xfaf.ssh.enable = lib.mkEnableOption "install 0x5a4s ssh config";

  config = lib.mkIf config.xfaf.ssh.enable {
    programs.ssh = {
      enable = true;
      package = pkgs.openssh;
      addKeysToAgent = "yes";
      matchBlocks =
        let
          teenixBlock = hostname: {
            inherit hostname;
            forwardAgent = true;
            extraOptions = {
              User = "arthur";
            };
          };

          teefax = teenixBlock "teefax.hhu-fscs.de";
          verleihnix = teenixBlock "verleihnix.hhu-fscs.de";
          sebigbos = teenixBlock "sebigbos.hhu-fscs.de";

          vps = teenixBlock "0x5a4.de";
        in
        {
          inherit teefax;
          "teefax.hhu-fscs.de" = teefax;
          "fscs.hhu.de" = teefax;
          "hhu-fscs.de" = teefax;

          inherit verleihnix;
          "dev.hhu-fscs.de" = verleihnix;
          "verleihnix.hhu-fscs.de" = verleihnix;

          inherit sebigbos;
          "sebigbos.hhu-fscs.de" = sebigbos;

          inherit vps;
          "0x5a4.de" = vps;
        };
    };
  };
}
