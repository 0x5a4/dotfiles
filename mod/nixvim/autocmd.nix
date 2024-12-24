{ pkgs, lib, ... }:
{
  extraConfigLuaPre = # lua
    ''
      local function runcmd(cmd, show_error)
          if type(cmd) == "string" then cmd = { cmd } end

          local result = vim.fn.system(cmd)
          local success = vim.api.nvim_get_vvar "shell_error" == 0
          if not success and (show_error == nil or show_error) then
              vim.api.nvim_err_writeln(("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result))
          end

          return success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
      end
    '';

  autoGroups.UserFileEvents = { };

  autoCmd = [
    {
      desc = "open help in a right vertical split";
      event = [ "BufWinEnter" ];
      pattern = [ "*txt" ];
      callback =
        lib.nixvim.mkRaw # lua
          ''
            function()
              if vim.o.filetype == "help" then
                  vim.cmd.wincmd("L")
              end
            end
          '';
    }
    {
      desc = "emit an event if visual mode is entered";
      event = [ "ModeChanged" ];
      pattern = "*:[vV\x16]*";
      callback =
        lib.nixvim.mkRaw # lua
          ''
            function()
              vim.api.nvim_exec_autocmds("User", {
                  pattern = "VisualEnter",
                  modeline = false,
              })
            end
          '';
    }
    {
      desc = "emit an event if visual mode is left";
      event = [ "ModeChanged" ];
      pattern = "[vV\x16]*:*";
      callback =
        lib.nixvim.mkRaw # lua
          ''
            function()
              vim.api.nvim_exec_autocmds("User", {
                  pattern = "VisualLeave",
                  modeline = false,
              })
            end
          '';
    }
    {
      event = [
        "BufReadPost"
        "BufNewFile"
        "BufWritePost"
      ];
      group = "UserFileEvents";
      callback =
        lib.nixvim.mkRaw # lua
          ''
            function(args)
              -- copy-pastad from astronvim
              local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
              
              if not (vim.fn.expand "%" == "" or  buftype == "nofile") then
                  vim.api.nvim_exec_autocmds("User", {
                      pattern = "File",
                      modeline = false,
                  })
                  if
                      runcmd({ "${lib.getExe pkgs.git}", "-C", vim.fn.expand "%:p:h", "rev-parse" }, false)
                  then
                      vim.api.nvim_exec_autocmds("User", {
                          pattern = "GitFile",
                          modeline = false,
                      })
                      vim.api.nvim_del_augroup_by_name("UserFileEvents")
                  end
              end
            end
          '';
    }
  ];
}
