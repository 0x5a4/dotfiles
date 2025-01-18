{
  config,
  pkgs,
  ...
}:
{
  xfaf.shell = {
    enableAliases = true;
    installTools = true;
    fish.enable = true;
    starship.enable = true;
    direnv.enable = true;
  };

  xfaf.git = {
    enable = true;
    userName = "0x5a4";
    userEmail = "54070204+0x5a4@users.noreply.github.com";
  };

  xfaf.ssh.enable = true;
  xfaf.btop.enable = true;
  xfaf.tmux.enable = true;
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

      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };

      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
    };

    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
    };

    opacity.terminal = 0.94;
  };

  xfaf.desktop.apps = {
    firefox = {
      enable = true;
      makeDefault = true;
    };
    kitty = {
      enable = true;
      makeDefault = true;
      openTmux = true;
    };
    rofi = {
      enable = true;
      makeDefault = true;
    };
    vencord.enable = true;
  };

  xfaf.desktop.wob.enable = true;
  xfaf.desktop.mako.enable = true;
  xfaf.desktop.swayidle.enable = true;
  xfaf.desktop.waybar.enable = true;

  home.sessionVariables = {
    FLAKE = config.home.homeDirectory + "/.dotfiles";
  };
}
