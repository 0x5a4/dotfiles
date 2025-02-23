{ lib, ... }:
let
  inherit (lib.nixvim)
    mkRaw
    ;

  mkSources = map (name: {
    inherit name;
  });

  defaultMappings = {
    "<C-j>" = "cmp.mapping.select_next_item()";
    "<C-k>" = "cmp.mapping.select_prev_item()";
    "<esc>" = "cmp.mapping.abort()";
    "<CR>" = "cmp.mapping.confirm({ select = true })";
  };

  cmdlineMappings = mkRaw ''
    {
      ["<Tab>"] = {
          c = function()
              if cmp.visible() then
                  cmp.select_next_item()
              else
                  cmp.complete()
              end
          end,
      },
      ["<S-Tab>"] = {
        c = cmp.mapping.select_prev_item()
      },
      ["<C-j>"] = {
          c = cmp.mapping.select_next_item()
      },
      ["<C-k>"] = {
          c = cmp.mapping.select_prev_item()
      },
      ["<esc>"] = {
          c = cmp.mapping.abort(),
      },
      ["<CR>"] = {
          c = cmp.mapping.confirm({ select = false }),
      },
    }
  '';

  completionMappings = defaultMappings // {
    "<C-s>" = "cmp.mapping.scroll_docs(4)";
    "<C-w>" = "cmp.mapping.scroll_docs(-4)";
    "<C-Space>" = "cmp.mapping.complete()";
  };

  border = [
    "╭"
    "─"
    "╮"
    "│"
    "╯"
    "─"
    "╰"
    "│"
  ];
in
{
  plugins = {
    cmp = {
      enable = true;
      cmdline = {
        "/" = {
          sources = mkSources [ "buffer" ];
          mapping = cmdlineMappings;
        };
        ":" = {
          mapping = cmdlineMappings;
          sources = [
            { name = "async_path"; }
            {
              name = "cmdline";
              option.ignore_cmds = [
                "Man"
                "!"
              ];
            }
          ];
        };
      };

      settings = {
        mapping = completionMappings;

        window = {
          completion.border = border;
          documentation.border = border;
        };

        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';

        sources = mkSources [
          "nvim_lsp"
          "luasnip"
          "async_path"
          "crates"
          "nvim_lua"
        ];
      };

    };

  };
}
