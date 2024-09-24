{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../mod/home-manager
  ];
  
  xfaf.shell = {
    enableAliases = true;
    installTools = true;
    fish.enable = true;
    starship.enable = true;
  };

  xfaf.git.enable = true;
  xfaf.ssh.enable = true;
  xfaf.btop.enable = true;
  xfaf.neovim = {
    enable = true;
    makeDefault = true;
  };

  home.stateVersion = "24.05";
}
