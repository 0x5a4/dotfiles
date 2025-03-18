{ outputs, ... }:
{
  imports = [ outputs.homeModules.xfaf ];

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

  programs.fish.interactiveShellInit = ''
    eval (ssh-agent -c) &> /dev/null
  '';

  home.stateVersion = "24.05";
}
