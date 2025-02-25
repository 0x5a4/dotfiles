{ lib, pkgs, ... }:
let
  inherit (lib.xfaf.nixvim)
    keyBindsFromAttrs
    noremap
    ;

  inherit (lib.nixvim)
    mkRaw
    ;
in
{
  extraConfigLua = ''
    vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
    vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

    local border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
    }

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end
  '';

  keymaps = keyBindsFromAttrs noremap {
    "<leader>ol" = ''<cmd>lua require("lsp_lines").toggle()<CR>'';
    "<C-f>" = mkRaw ''
      function()
          require("conform").format({ async = true, lsp_fallback = true })
      end
    '';
  };

  extraPackages = with pkgs; [
    nixfmt-rfc-style
  ];

  plugins = {
    none-ls = {
      enable = true;

      settings.border = "rounded";

      sources = {
        diagnostics = {
          hadolint.enable = true;

          fish.enable = true;
        };
        formatting = {
          prettierd = {
            enable = true;
            disableTsServerFormatter = true;

            settings.disabled_filetypes = [
              "html"
              "css"
            ];
          };
        };
      };
    };

    conform-nvim = {
      enable = true;

      luaConfig.post = ''
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      '';
    };

    lsp-signature = {
      enable = true;
      settings.hint_prefix = "";
    };

    lsp = {
      enable = true;
      inlayHints = true;

      capabilities = ''
        capabilities.textDocument.completion.completionItem.snippetSupport = true
      '';

      servers = {
        bashls.enable = true;

        clangd.enable = true;

        clojure_lsp.enable = true;

        hls = {
          enable = true;
          installGhc = true;
        };

        html = {
          enable = true;
          settings.format.enable = true;
        };

        ts_ls.enable = true;

        texlab.enable = true;

        lua_ls = {
          enable = true;
          settings.Lua = {
            diagnostics.globals = [
              "vim"
            ];
            format.defaultConfig = {
              quote_style = "double";
              trailing_table_separator = "smart";
              end_statement_with_semicolon = "replace_with_newline";
              line_space_after_do_statement = "fixed(2)";
              line_space_after_for_statement = "fixed(2)";
              line_space_after_if_statement = "fixed(2)";
              line_space_after_repeat_statement = "fixed(2)";
              line_space_after_while_statement = "fixed(2)";
            };
          };
        };

        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };

        nixd = {
          enable = true;
          settings.nixd = {
            nixpkgs.expr = "import <nixpkgs> { }";
            formatting.command = [ "nixfmt" ];
            options = {
              nixos.expr = ''(builtins.elemAt (builtins.attrValues (builtins.getFlake "xfaf-config").nixosConfigurations) 0).options'';
              nixvim.expr = ''(builtins.getFlake "xfaf-config").packages.${pkgs.stdenv.system}.nixvim.options'';
            };
          };
        };

        pyright.enable = true;

        zls.enable = true;
      };
    };
  };
}
