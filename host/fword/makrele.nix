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
  xfaf.neovim = {
    enable = true;
    makeDefault = true;
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

  xfaf.desktop.apps = {
    firefox = {
      enable = true;
      makeDefault = true;
    };
    kitty = {
      enable = true;
      makeDefault = true;
    };
    rofi = {
      enable = true;
      makeDefault = true;
    };
  };

  xfaf.desktop.hyprland = {
    enable = true;
    cursor_warps = true;
  };

  xfaf.desktop.wob.enable = true;
  xfaf.desktop.batsignal.enable = true;
  xfaf.desktop.mako.enable = true;
  xfaf.desktop.swayidle.enable = true;
  xfaf.desktop.waybar.enable = true;

  xfaf.desktop.monitors = {
    "eDP-1" = {
      scale = 1.175;
      primary = true;
      workspaces = lib.lists.range 1 9;
      defaultWorkspace = 1;
    };
    "DP-1" = {
      workspaces = [0];
      defaultWorkspace = 0;
    };
    "DP-2" = {
      workspaces = [0];
      defaultWorkspace = 0;
    };
    "DP-3" = {
      workspaces = [0];
      defaultWorkspace = 0;
    };
    "DP-4" = {
      workspaces = [0];
      defaultWorkspace = 0;
    };
  };

  home.sessionVariables = {
    "FLAKE" = config.home.homeDirectory + "/.dotfiles";
  };

  home.packages = with pkgs; [
    vesktop
    spotify
    prismlauncher
    cargo
    rustc
    rustfmt
    clippy
    zig
  ];

  home.stateVersion = "23.11";
}
