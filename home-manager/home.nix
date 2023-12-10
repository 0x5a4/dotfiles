{
  config,
  pkgs,
  ...
}: {
  home.username = "notuser";
  home.homeDirectory = "/home/notuser";
  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;

  imports = [
    ./share/cmdline.nix
    ./share/browser.nix
    ./share/apps.nix
  ];

  home.packages = [
    pkgs.noto-fonts
    pkgs.noto-fonts-emoji
    (pkgs.nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
    # EDITOR = "emacs";
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };
  };

  programs.home-manager.enable = true;
}
