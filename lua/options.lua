vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = false

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.clipboard = "unnamedplus"

vim.opt.scrolloff = 999

vim.opt.inccommand = "split"
vim.opt.ignorecase = true

vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.mouse = ""
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.formatoptions:append({ "r" })
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.textwidth = 100
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true

-- setup diagnostics
vim.diagnostic.config({
  virtual_lines = false,
  float = true
})

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = false })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
