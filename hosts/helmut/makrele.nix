{
  pkgs,
  config,
  outputs,
  ...
}:
{
  imports = [
    outputs.homeModules.xfaf
  ];

  xfaf.shell = {
    enableAliases = true;
    installTools = true;
    fish.enable = true;
    starship.enable = true;
    direnv.enable = true;
  };

  xfaf.git.enable = true;

  xfaf.ssh.enable = true;
  xfaf.btop.enable = true;
  xfaf.tmux.enable = true;
  xfaf.neovim = {
    enable = true;
    makeDefault = true;
  };

  home.enableNixpkgsReleaseCheck = false;

  home.sessionVariables = {
    FLAKE = config.home.homeDirectory + "/.dotfiles";
  };

  home.stateVersion = "23.11";
}
