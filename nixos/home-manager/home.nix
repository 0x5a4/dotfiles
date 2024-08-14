{
  config,
  lib,
  pkgs,
  ...
}: {
  home.username = "notuser";
  home.homeDirectory = "/home/notuser";
  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./browser.nix
    ./waybar.nix
    ./fish.nix
    ./hyprland.nix
    ./tmux.nix
  ];

  home.packages = [
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];

  home.file = {
    ".config/swayidle/config".source = ../../config/swayidle/config;
    ".config/btop/btop.conf".source = ../../config/btop/btop.conf;
    ".config/mako/config".source = ../../config/mako/config;
    ".config/starship.toml".source = ../../config/starship.toml;
    ".config/wob/wob.ini".source = ../../config/wob/wob.ini;
    ".config/nvim" = {
      source = ../../config/nvim;
      recursive = true;
    };
    ".gitconfig".source = ../../gitconfig;
    ".gitignore".source = ../../gitignore;
    ".bash_profile".source = ../../bash_profile;
    ".bashrc".source = ../../bashrc;
    ".local/bin" = {
      source = ../../local/bin;
      recursive = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/notuser/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.openssl.dev}/lib/pkgconfig";
    # EDITOR = "emacs";
  };

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = let
      rofi-calc-wayland =
        pkgs.rofi-calc.overrideAttrs
        (finalAttrs: previousAttrs: let
          unRofiInputs = lib.lists.remove pkgs.rofi-unwrapped previousAttrs.buildInputs;
        in {
          buildInputs = unRofiInputs ++ [pkgs.rofi-wayland];
        });
    in [
      rofi-calc-wayland
    ];
    theme = ../../config/rofi/style.rasi;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    extraConfig = ''
      IdentityFile ~/.ssh/key
    '';
    matchBlocks = {
      teefax = {
        host = "fscs-hhu.de";
        extraOptions = {
          ForwardAgent = "yes";
        };
      };
    };
  };

  services.ssh-agent.enable = true;

  programs.home-manager.enable = true;

  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableBashIntegration = true;
      enableFishIntegration = true;
    };

    font = {
      size = 10;
      package = pkgs.monocraft;
      name = "Monocraft Nerd Font Complete";
    };

    keybindings = {
      "ctrl+plus" = "change_font_size all +1.0";
      "ctrl+minus" = "change_font_size all -1.0";
    };

    settings = {
      background_opacity = "0.94";
      update_check_interval = 0;
      confirm_os_window_close = 0;
      mouse_hide_wait = 0;
      notify_on_cmd_finish = "invisible 30";
      disable_ligatures = "always";
      font_features = "MonocraftNerdFontComplete- -liga";

      foreground = "#f8f8f2";
      background = "#282a36";
      selection_foreground = "#ffffff";
      selection_background = "#44475a";

      url_color = "#8be9fd";

      # black
      color0 = "#21222c";
      color8 = "#6272a4";

      # red
      color1 = "#ff5555";
      color9 = "#ff6e6e";

      # green
      color2 = "#50fa7b";
      color10 = "#69ff94";

      # yellow
      color3 = "#f1fa8c";
      color11 = "#ffffa5";

      # blue
      color4 = "#bd93f9";
      color12 = "#d6acff";

      # magenta
      color5 = "#ff79c6";
      color13 = "#ff92df";

      # cyan
      color6 = "#8be9fd";
      color14 = "#a4ffff";

      # white
      color7 = "#f8f8f2";
      color15 = "#ffffff";

      # Cursor colors
      cursor = "#f8f8f2";
      cursor_text_color = "background";

      # Tab bar colors
      active_tab_foreground = "#282a36";
      active_tab_background = "#f8f8f2";
      inactive_tab_foreground = "#282a36";
      inactive_tab_background = "#6272a4";

      # Marks
      mark1_foreground = "#282a36";
      mark1_background = "#ff5555";

      # Splits/Windows
      active_border_color = "#f8f8f2";
      inactive_border_color = "#6272a4";
    };
  };
}
