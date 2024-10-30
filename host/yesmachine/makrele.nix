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

  xfaf.desktop.monitors = let
    wallpaper-image = pkgs.fetchurl {
      name = "fword-wallpaper-image";
      url = "https://images.wallpapersden.com/image/download/galaxies-pixel-art_bGpsaW6UmZqaraWkpJRnamtlrWZlbWU.jpg";
      hash = "sha256-Em1ECfdippXbFn7X4hOnqnzCONRt/Y00bFINdCvhe7M=";
    };

    wallpaper = pkgs.runCommandLocal "fword-wallpaper" {} ''
      ${pkgs.imagemagick}/bin/convert -crop 50%x100% ${wallpaper-image} output.png
      mkdir $out
      mv output-0.png $out/left.png
      mv output-1.png $out/right.png
    '';
  in {
    HDMI-A-1 = {
      workspaces = lib.lists.range 1 5;
      defaultWorkspace = 1;
      wallpaper = "${wallpaper}/right.png";
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
      wallpaper = "${wallpaper}/left.png";
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
    element-desktop
    prismlauncher
    spotify
    vesktop
  ];

  home.stateVersion = "24.05";
}
