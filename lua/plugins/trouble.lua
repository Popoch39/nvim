return {
  "folke/trouble.nvim",
  opts = {
    icons = {
      indent = {
        middle = " ",
        last = " ",
        top = " ",
        ws = "│  ",
      },
    },
    position = "right", -- position de la fenêtre Trouble
    height = 10,        -- hauteur de la fenêtre
    modes = {
      mydiags = {
        mode = "diagnostics", -- inherit from diagnostics mode
        filter = {
          any = {
            buf = 0,                                  -- current buffer
            {
              severity = vim.diagnostic.severity.ERROR, -- errors only
              -- limit to files in the current project
              function(item)
                return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
              end,
            },
          },
        },
      }
    },
    fold_open = "",       -- icône pour les sections ouvertes
    fold_closed = "",     -- icône pour les sections fermées
    action_keys = {       -- personnalisation des touches
      next = "j",         -- aller au problème suivant
      previous = "k",     -- aller au problème précédent
      close = "q",        -- fermer la fenêtre
      jump = "<cr>",      -- aller à l'emplacement du problème
      toggle_fold = "za", -- plier/déplier une section
    },
  },
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle mode=workspace filter.severity=vim.diagnostic.severity.ERROR win.type = split win.position=right<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle win.type = split win.position=right<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>cs",
      "cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>cl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
