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
      sizes.terminal = 10;
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
  };

  xfaf.desktop.hyprland.enable = true;

  xfaf.desktop.wob.enable = true;
  xfaf.desktop.batsignal.enable = true;
  xfaf.desktop.mako.enable = true;
  xfaf.desktop.swayidle.enable = true;
  xfaf.desktop.waybar.enable = true;

  xfaf.desktop.monitors = {
    HDMI-A-1 = {
      workspaces = lib.lists.range 1 5;
      defaultWorkspace = 1;
      wallpaper = config.stylix.image;
      bar = {
        enable = true;
        modules.left = {
          clock = true;
        };
        modules.right = {
          uptime = true;
          volume = true;
          idle-inhibit = true;
        };
      };
    };
    DP-1 = {
      workspaces = lib.lists.range 6 10;
      defaultWorkspace = 6;
      wallpaper = config.stylix.image;
      bar = {
        enable = true;
        modules.left = {
          system-load = true;
          network = true;
        };
        modules.right = {
          clock = true;
          hyprland-workspaces = true;
          hyprland-submap = true;
        };
      };
    };
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
