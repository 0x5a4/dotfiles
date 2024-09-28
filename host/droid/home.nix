{
  inputs,
  outputs,
  ...
}: {
  imports = [
    outputs.homeModules.xfaf
    inputs.stylix.homeManagerModules.stylix
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
