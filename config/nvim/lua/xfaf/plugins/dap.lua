return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            -- this is a bit fucked up. but everytime dap loads, we also want to load these
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
        keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end },
            { "<F5>",       function() require("dap").continue() end },
            { "<F6>",       function() require("dap").step_into() end },
            { "<F7>",       function() require("dap").step_over() end },
            { "<F8>",       function() require("dap").step_out() end },
            { "<F9>",       function() require("dap").step_back() end },
            { "<F10>",      function() require("dap").stop() end },
            { "<F12>",      function() require("dap").restart() end },
        },
        config = function()
            local dap = require("dap")

            local function find_root(markers)
                local result = vim.fs.find(
                    markers,
                    {
                        upward = true,
                        path = vim.fn.expand("%:p:h"),
                    }
                )
                return next(result) and vim.fs.dirname(result[1]) or vim.fn.getcwd()
            end

            local function find_program(search_paths, markers, builder)
                return function()
                    return coroutine.create(function(run)
                        local root = find_root(markers)

                        -- find all executables in search paths
                        local executables = {}

                        for _, search in ipairs(search_paths) do
                            local dir = vim.fs.joinpath(root, search)
                            for child, path_type in vim.fs.dir(dir) do
                                if path_type == "file" then
                                    local perm = vim.fn.getfperm(vim.fs.joinpath(dir, child))
                                    if string.match(perm, "x", 3) then
                                        table.insert(executables, vim.fs.joinpath(search, child))
                                    end
                                end
                            end
                        end

                        vim.notify("Running '" .. builder .. "'", vim.log.levels.INFO)
                        vim.cmd("!" .. builder)

                        if #executables == 1 then
                            vim.notify("Debugging " .. executables[1], vim.log.levels.INFO)
                            coroutine.resume(run, vim.fs.joinpath(root, executables[1]))
                        elseif #executables > 1 then
                            vim.ui.select(executables, { prompt = "Select executable" }, function(choice)
                                if not choice then
                                    coroutine.resume(run, dap.ABORT)
                                end

                                vim.notify("Debugging " .. choice, vim.log.levels.INFO)
                                coroutine.resume(run, vim.fs.joinpath(root, choice))
                            end)
                        else
                            vim.notify("No executables found in search paths (root was '" .. root .. "')",
                                vim.log.levels.WARN)
                            coroutine.resume(run, dap.ABORT)
                        end
                    end)
                end
            end

            local function make_lldb_config(name, search_paths, markers, builder)
                return {
                    name = name,
                    type = "codelldb",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    program = find_program(search_paths, markers, builder),
                    args = function()
                        return coroutine.create(function(run)
                            vim.ui.input({ prompt = "Specify Arguments" }, function(input)
                                coroutine.resume(run, vim.split(input or "", " "))
                            end)
                        end)
                    end,
                }
            end

            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "codelldb",
                    args = { "--port", "${port}" },
                },
            }

            dap.configurations.c = {
                make_lldb_config("Build (make) & Debug", { ".", "build" }, { "Makefile", "meson.build", ".git" }, "make"),
            }

            dap.configurations.zig = {
                make_lldb_config("Build & Debug", { "zig-out/bin", ".zig-out/bin" }, { "build.zig", ".git" }, "zig build"),
            }

            dap.configurations.rust = {
                make_lldb_config("Build & Debug", { "target/debug" }, { "Cargo.lock" }, "cargo build"),
            }
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio",
        },
        keys = {
            { "<leader>do", function() require("dapui").toggle() end },
        },
        config = function()
            require("dapui").setup({})

            local dap = require("dap")
            local dapui = require("dapui")

            dap.listeners.before.attach.dapui_config = dapui.open
            dap.listeners.before.launch.dapui_config = dapui.open
        end,
    },
    {
        "theHamsta/nvim-dap-virtual-text",
        lazy = true,
        opts = {
            display_callback = function(variable)
                local name = string.lower(variable.name)
                local value = string.lower(variable.value)
                if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
                    return "*****"
                end

                if #variable.value > 15 then
                    return " " .. string.sub(variable.value, 1, 15) .. "... "
                end

                return " " .. variable.value
            end,
        },
    },
}
