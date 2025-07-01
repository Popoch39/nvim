vim.keymap.set("n", "tn", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
vim.keymap.set("n", "tp", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("buffer #") end,
    { desc = "aller au précedent buffer", silent = true })

vim.keymap.set("n", "<C-s>", vim.cmd.write, { desc = "Save file", silent = true, noremap = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { desc = "Save file",  silent = true, noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", {});
vim.keymap.set("n", "<C-u>", "<C-u>zz", {});
