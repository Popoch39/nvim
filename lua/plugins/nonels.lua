return {
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")

            local signs = {
                Error = "",
                Warn  = "",
                Hint  = "",
                Info  = ""
            }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            vim.diagnostic.config({
                virtual_text = {
                    source = true,
                    prefix = "●", -- ou "■", "▎", "●" etc
                    spacing = 4,
                },
                float = {
                    source = true,
                    border = "rounded",
                },
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            })

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.pint,
                    null_ls.builtins.formatting.blade_formatter,
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = { "html", "css", "scss", "json", "yaml", "markdown" },
                    }),
                    null_ls.builtins.diagnostics.phpstan,
                },
            })
            vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
        end,
        dependencies = {
            "nvim-lua/plenary.nvim"
        }
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
        opts = {
            ensure_installed = { "pint", "phpstan", "blade-formatter", "prettier" },
        },
    }

}
