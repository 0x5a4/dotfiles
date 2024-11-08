{
  config,
  pkgs,
  lib,
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

  xfaf.desktop.monitors =
    let
      wallpaper = pkgs.fetchurl {
        name = "fword-wallpaper";
        url = "https://img.itch.zone/aW1hZ2UvOTY3MDg0LzU1MjAyMTIucG5n/794x1000/K13gwE.png";
        hash = "sha256-psw6lxfxAcRSNZ/7Y3EQvpukL8HYpr0H96Wld3qL+wU=";
      };

      externalConfig = {
        inherit wallpaper;
        workspaces = [ 0 ];
        defaultWorkspace = 0;
        bar = {
          enable = true;
          modules.left = {
            clock = true;
            system-load = true;
          };
          modules.right = {
            battery = true;
            volume = true;
            network = true;
          };
        };
      };
    in
    {
      eDP-1 = {
        inherit wallpaper;
        scale = 1.175;
        workspaces = lib.lists.range 1 9;
        defaultWorkspace = 1;
        bar = {
          enable = true;
          modules.left = {
            clock = true;
            hyprland-workspaces = true;
            system-load = true;
            network = true;
            bluetooth = true;
          };
          modules.right = {
            uptime = true;
            battery = true;
            volume = true;
            brightness = true;
            idle-inhibit = true;
            hyprland-submap = true;
          };
        };
      };
      DP-1 = externalConfig;
      DP-2 = externalConfig;
      DP-3 = externalConfig;
      DP-4 = externalConfig;
    };

  home.sessionVariables = {
    FLAKE = config.home.homeDirectory + "/.dotfiles";
  };

  home.packages = with pkgs; [
    element-desktop
    prismlauncher
    spotify
    thunderbird
    libreoffice
    vesktop
  ];

  home.stateVersion = "23.11";
}
