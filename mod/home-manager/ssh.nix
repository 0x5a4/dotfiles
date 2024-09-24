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
          hostname = "fscs.hhu.de";
          forwardAgent = true;
          extraOptions = {
            User = "tischgoblin";
          };
        };
      };
    };
  };
}
