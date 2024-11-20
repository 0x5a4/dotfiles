{
  inputs,
  outputs,
  ...
}:
{
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

  xfaf.git = {
    enable = true;
    userName = "0x5a4";
    userEmail = "54070204+0x5a4@users.noreply.github.com";
  };

  xfaf.ssh.enable = true;
  xfaf.btop.enable = true;
  xfaf.neovim = {
    enable = true;
    makeDefault = true;
  };

  programs.fish.interactiveShellInit = ''
    eval (ssh-agent -c) &> /dev/null
  '';

  home.stateVersion = "24.05";
}
