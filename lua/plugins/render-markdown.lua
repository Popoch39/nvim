return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown" },
    keys = {
        { "<leader>md", "<cmd>RenderMarkdown toggle<cr>", desc = "Toggle render-markdown" },
    },
    opts = {
        html = { enabled = false },
        latex = { enabled = false },
        yaml = { enabled = false },
    },
}
