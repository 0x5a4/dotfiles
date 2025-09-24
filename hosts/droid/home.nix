{ outputs, ... }:
{
  imports = [ outputs.homeModules.xfaf ];

  xfaf.shell = {
    enableAliases = true;
    installTools = true;
    fish.enable = true;
    starship.enable = true;
  };

  programs.fish.interactiveShellInit = ''
    eval (ssh-agent -c) &> /dev/null
  '';

  home.stateVersion = "24.05";
}
