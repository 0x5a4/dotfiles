{ xfaf-lib, lib, ... }:
with xfaf-lib.nixvim;
with lib.nixvim;
{
  plugins = {
    web-devicons.enable = true;

    numbers-nvim = {
      enable = true;
      lazyLoad.enable = true;
      lazyLoad.settings.event = veryLazyEvent;
    };

    cellular-automaton = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.cmd = "CellularAutomaton";
        settings.keys =
          lazyKeyBindsOf
          <| keyBindsFromAttrs nnoremap {
            "<leader>fml" = "<cmd>CellularAutomaton make_it_rain<CR>";
          };
      };
    };

    duck = {
      enable = true;
      lazyLoad = {
        enable = true;
        settings.keys =
          lazyKeyBindsOf
          <| keyBindsFromAttrs nnoremap {
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
      };
    };

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
      lazyLoad.enable = true;
      lazyLoad.settings.event = veryLazyEvent;
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
      notification.overrideVimNotify = true;
    };

    visual-whitespace = {
      enable = true;
      settings.space_char = " ";
      lazyLoad.enable = true;
      lazyLoad.settings.event = "User VisualEnter";
    };

    scroll-eof = {
      enable = true;
      settings.insert_mode = true;
      lazyLoad.enable = true;
      lazyLoad.settings.event = veryLazyEvent;
    };
  };
}