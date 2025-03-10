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
              User = "tischgoblin";
            };
          };
        in
        {
          teefax = teenixBlock "fscs.hhu.de";
          "fscs.hhu.de" = teenixBlock "fscs.hhu.de";
          testfax = teenixBlock "dev.hhu-fscs.de";
          "dev.hhu-fscs.de" = teenixBlock "dev.hhu-fscs.de";
          helmut.forwardAgent = true;
        };
    };
  };
}
