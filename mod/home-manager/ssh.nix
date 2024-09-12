{
  lib,
  config,
  ...
}: {
  options.xfaf.ssh.enable = lib.mkEnableOption "install 0x5a4s ssh config";

  config = lib.mkIf config.xfaf.ssh.enable {
    services.ssh-agent.enable = true;

    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      extraConfig = ''
        IdentityFile ~/.ssh/key
      '';
      matchBlocks = {
        teefax = {
          host = "fscs.hhu.de hhu-fscs.de";
          extraOptions = {
            forwardAgent = "yes";
          };
        };
      };
    };
  };
}
