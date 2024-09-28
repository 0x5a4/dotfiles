{
  lib,
  config,
  pkgs,
  ...
}: {
  options.xfaf.neovim = {
    enable = lib.mkEnableOption "install 0x5a4s neovim config";
    makeDefault = lib.mkEnableOption "make neovim the default editor";
    extraLsps = lib.mkOption {
      description = "list of extra lsps to install";
      type = lib.types.listOf lib.types.package;
      default = [];
    };
  };

  config = let
    opts = config.xfaf.neovim;
  in
    lib.mkIf opts.enable {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = lib.mkIf opts.makeDefault {
          "text/plain" = "neovim.desktop";
        };
      };

      programs.neovim = {
        enable = true;
        defaultEditor = opts.makeDefault;
        viAlias = true;
        vimAlias = true;
        withPython3 = true;
      };

      home.packages = with pkgs;
        [
          # lsps
          alejandra
          beautysh
          black
          clang-tools
          clojure-lsp
          hadolint
          lua-language-server
          marksman
          nil
          nodePackages.bash-language-server
          prettierd
          pyright
          ruff
          rust-analyzer
          taplo
          texlab
          vscode-langservers-extracted
          zls
          # other stuff
          ripgrep
          gcc
          git # for lazy
          # for tex preview
          zathura
          texliveFull
        ]
        ++ opts.extraLsps;

      home.file = {
        ".config/nvim" = {
          source = ../../config/nvim;
          recursive = true;
        };

        ".config/zathura/zathurarc".text = ''
          set render-loading false
        '';
      };
    };
}
