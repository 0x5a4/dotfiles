{ lib, ... }:
let
  inherit (lib.xfaf.nixvim)
    veryLazyEvent
    keyBindsFromAttrs
    nnoremap
    ;

  inherit (lib.nixvim)
    mkRaw
    listToUnkeyedAttrs
    ;
in
{
  keymaps = keyBindsFromAttrs nnoremap {
    "<leader>fml" = "<cmd>CellularAutomaton make_it_rain<CR>";
    "<leader>fc" = "<cmd>lua require('duck').cook()<CR>";
    "<leader>fd" = mkRaw ''
      function()
        local filetype = vim.bo.filetype
        local d_u_c_k = {
            rust = "🦀",
            zig = "🦎",
            lua = "🌚",
            nix = ""
        }

        local icon = d_u_c_k[filetype] or "🦆"

        if math.random(50) == 1 then
            icon = "ඞ"
        end

        require("duck").hatch(icon, 5)
      end
    '';
  };

  plugins = {
    cheatsheet.cheatsheet = {
      fun = {
        "<leader>fml" = "Make it rain!";
        "<leader>fc" = "Bye Bye companion";
        "<leader>fd" = "Summon an emotional support companion";
      };
    };

    web-devicons.enable = true;

    numbers-nvim.enable = true;

    cellular-automaton.enable = true;

    duck.enable = true;

    lualine = {
      enable = true;
      settings = {
        options = {
          globalstatus = true;
          theme = "tokyonight";
        };
        sections = {
          lualine_a = [ "mode" ];
          lualine_b = [
            "branch"
            "diff"
            (
              (listToUnkeyedAttrs [ "diagnostics" ])
              // {
                sources = [ "nvim_lsp" ];
                sections = [
                  "error"
                  "warn"
                  "info"
                ];
              }
            )
          ];
          lualine_c = [ "filename" ];
          lualine_x = [
            "encoding"
            "fileformat"
            "filetype"
          ];
          lualine_y = [ "progress" ];
          lualine_z = [ "location" ];
        };
      };
    };

    dressing = {
      enable = true;
      settings.input.relative = "editor";
    };

    bufferline = {
      enable = true;
      settings.options = {
        show_close_icon = false;
        show_buffer_close_icons = false;
      };
    };

    fidget = {
      enable = true;
      settings.notification.override_vim_notify = true;
    };

    visual-whitespace = {
      enable = true;
      settings.space_char = " ";
    };

    scroll-eof = {
      enable = true;
      settings.insert_mode = true;
    };
  };
}
