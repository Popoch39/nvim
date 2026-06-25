return {
    "pwntester/octo.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    cmd = "Octo",
    keys = {
        { "<leader>gh", "<cmd>Octo issue list<cr>", desc = "GitHub Issues" },
    },
    opts = {
        mappings = {
            issue = {
                add_comment = { lhs = "<leader>cc", desc = "Add comment" },
            },
            pull_request = {
                add_comment = { lhs = "<leader>cc", desc = "Add comment" },
            },
            review_thread = {
                add_comment = { lhs = "<leader>cc", desc = "Add comment" },
            },
        },
    },
}
