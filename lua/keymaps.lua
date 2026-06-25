vim.keymap.set("n", "tn", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Next Diagnostic" })
vim.keymap.set("n", "tp", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous Diagnostic" })
vim.keymap.set("n", "<leader><leader>", function() vim.cmd("buffer #") end,
    { desc = "aller au précedent buffer", silent = true })

vim.keymap.set("n", "<C-s>", vim.cmd.write, { desc = "Save file", silent = true, noremap = true })
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>", { desc = "Save file",  silent = true, noremap = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", {});
vim.keymap.set("n", "<C-u>", "<C-u>zz", {});
vim.keymap.set({"n", "i"}, "<M-a>", "<Esc>A", { desc = "Go to end of line in insert mode", silent = true, noremap = true })

vim.keymap.set("n", "<M-j>", "<cmd>cnext <CR>");
vim.keymap.set("n", "<M-k>", "<cmd>cprev <CR>");
vim.keymap.set("n", "<M-q>", "<cmd>cclose <CR>");
vim.keymap.set("n", "<M-o>", "<cmd>copen <CR>");

