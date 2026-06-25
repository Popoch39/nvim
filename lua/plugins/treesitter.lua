return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ensure_installed = {
            "c", "rust", "typescript", "tsx", "javascript", "lua", "vim",
            "vimdoc", "query", "markdown", "markdown_inline",
            "php", "phpdoc",
        }

        local nts = require("nvim-treesitter")
        local installed = nts.get_installed("parsers")
        local missing = vim.tbl_filter(function(lang)
            return not vim.list_contains(installed, lang)
        end, ensure_installed)
        if #missing > 0 then
            nts.install(missing)
        end

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
                if not vim.list_contains(nts.get_installed("parsers"), lang) then
                    return
                end
                pcall(vim.treesitter.start, ev.buf, lang)
                vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
