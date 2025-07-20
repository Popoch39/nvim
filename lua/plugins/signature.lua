return {
  "ray-x/lsp_signature.nvim",
  event = "BufRead",
  opts = {
    bind = true, -- Activer automatiquement quand vous tapez
    handler_opts = {
      border = "rounded" -- Pour un joli cadre
    },
    hint_prefix = "💡 ",
  },
  config = function(_, opts)
    require("lsp_signature").setup(opts)
  end,
}
