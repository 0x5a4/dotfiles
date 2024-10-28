return {
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            local jdtls = require("jdtls")
            local jdtlsd = require("jdtls.dap")

            local path = {}

            path.bundles = {
                vim.fn.glob(
                    os.getenv("JAVA_DEBUG") ..
                    "com.microsoft.java.debug.plugin-*.jar", 1),
            }


            local lsp_settings = {
                java = {
                    eclipse = {
                        downloadSources = true,
                    },
                    configuration = {
                        updateBuildConfiguration = "interactive",
                        runtimes = path.runtimes,
                    },
                    maven = {
                        downloadSources = true,
                    },
                    implementationsCodeLens = {
                        enabled = true,
                    },
                    referencesCodeLens = {
                        enabled = true,
                    },
                    format = {
                        enabled = true,
                    },
                },
                signatureHelp = {
                    enabled = false,
                },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                    },
                },
                contentProvider = {
                    preferred = "fernflower",
                },
                extendedClientCapabilities = jdtls.extendedClientCapabilities,
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                codeGeneration = {
                    toString = {
                        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    useBlocks = true,
                },
            }

            local function jdtls_on_attach(client, bufnr)
                jdtls.setup_dap({ hotcodereplace = "auto" })
                jdtlsd.setup_dap_main_class_configs()

                require("jdtls.dap").setup_dap_main_class_configs()
            end

            local config = {
                cmd = { "jdtls" },
                root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
                init_options = {
                    bundles = path.bundles,
                },
                settings = lsp_settings,
                on_attach = jdtls_on_attach,
            }
            jdtls.start_or_attach(config)
        end,
    },
}
