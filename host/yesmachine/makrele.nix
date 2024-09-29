{
  config,
  pkgs,
  lib,
  outputs,
  ...
}: {
  imports = [
    outputs.homeModules.xfaf
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
  xfaf.tmux.enable = false;
  xfaf.neovim = {
    enable = true;
    makeDefault = true;
    extraLsps = [
      pkgs.nodePackages.typescript-language-server
    ];
  };

  stylix = {
    fonts = {
      monospace = {
        package = pkgs.monocraft;
        name = "Monocraft Nerd Font Complete";
      };
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
    };

    opacity.terminal = 0.94;
  };

  home.sessionVariables = {
    FLAKE = config.home.homeDirectory + "/.dotfiles";
  };

  home.packages = with pkgs; [
    cargo
    clippy
    element-desktop-wayland
    prismlauncher
    rustc
    rustfmt
    spotify
    vesktop
    zig
  ];

  home.stateVersion = "24.05";
}
