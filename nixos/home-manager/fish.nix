{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.file = {
    ".config/fish" = {
      source = ../../config/fish;
      recursive = true;
    };
  };

  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "autopair.fish";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "puffer-fish";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "colored-man-pages.fish";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
      {
        name = "fish-autovenv";
        src = pkgs.fetchFromGitHub {
          owner = "timothybrown";
          repo = "fish-autovenv";
          rev = "5d4e1f643d8b79109c8a1b4d254bfbe39d43122a";
          sha256 = "sha256-dMLViWHeHynnvu+ZuvDUQPMMEHoTs0Vu8mwv4gmnms8=";
        };
      }
      {
        name = "gitnow";
        src = pkgs.fetchFromGitHub {
          owner = "joseluisq";
          repo = "gitnow";
          rev = "91bda1d0ffad2d68b21a1349f9b55a8cb5b54f35";
          sha256 = "sha256-PuorwmaZAeG6aNWX4sUTBIE+NMdn1iWeea3rJ2RhqRQ=";
        };
      }
      {
        name = "plugin-foreign-env";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-foreign-env";
          rev = "7f0cf099ae1e1e4ab38f46350ed6757d54471de7";
          sha256 = "sha256-4+k5rSoxkTtYFh/lEjhRkVYa2S4KEzJ/IJbyJl+rJjQ=";
        };
      }
    ];
  };
}
