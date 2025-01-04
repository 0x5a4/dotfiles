{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.xfaf.neovim = {
    enable = lib.mkEnableOption "install 0x5a4s neovim config";
    makeDefault = lib.mkEnableOption "make neovim the default editor";
    extraLsps = lib.mkOption {
      description = "list of extra lsps to install";
      type = lib.types.listOf lib.types.package;
      default = [ ];
    };
  };

  config =
    let
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
        extraLuaPackages =
          luaPkgs: with luaPkgs; [
            luautf8
          ];
        extraPackages =
          with pkgs;
          [
            # lsps
            beautysh
            black
            clang-tools
            clojure-lsp
            hadolint
            jdt-language-server
            lua-language-server
            marksman
            nixd
            nixfmt-rfc-style
            nodePackages.bash-language-server
            prettierd
            pyright
            ruff
            rust-analyzer
            taplo
            texlab
            vscode-extensions.vadimcn.vscode-lldb.adapter
            vscode-extensions.vscjava.vscode-java-debug
            vscode-langservers-extracted
            zls
            # other stuff
            gcc # for treesitter
            tree-sitter
            nodejs
            git # for lazy
            ripgrep # for telescope
          ]
          ++ opts.extraLsps;
      };

      home.packages = with pkgs; [
        zathura # for tex preview
      ];

      home.sessionVariables = {
        JAVA_DEBUG_ADAPTER = "${pkgs.vscode-extensions.vscjava.vscode-java-debug}/share/vscode/extensions/vscjava.vscode-java-debug/server/";
      };

      home.file = {
        ".config/nvim" = {
          source = ./config;
          recursive = true;
        };

        ".config/zathura/zathurarc".text = ''
          set render-loading false
        '';
      };
    };
}
