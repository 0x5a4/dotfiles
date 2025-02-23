{ lib, ... }:
let
  mkSources = map (name: {
    inherit name;
  });

  defaultMappings = {
    "<C-j>" = "cmp.mapping.select_next_item()";
    "<C-k>" = "cmp.mapping.select_prev_item()";
    "<esc>" = "cmp.mapping.abort()";
    "<CR>" = "cmp.mapping.confirm({ select = true })";
  };

  cmdlineMappings = defaultMappings;

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
          sources = [
            { name = "path"; }
            {
              name = "cmdline";
              option.ignore_cmds = [
                "Man"
                "!"
              ];
            }
          ];
          mapping = cmdlineMappings;
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
          "path"
          "crates"
          "nvim_lua"
        ];
      };

    };

  };
}
