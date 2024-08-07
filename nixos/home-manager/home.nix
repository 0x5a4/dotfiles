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
    ".config/kitty/kitty.conf".source = ../../config/kitty/kitty.conf;
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
}
