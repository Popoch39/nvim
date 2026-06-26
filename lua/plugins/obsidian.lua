-- Notes & todos par projet : vault centralisé ~/notes/, un fichier markdown par
-- projet ouvert dans une fenêtre flottante. obsidian.nvim gère le vault (checkbox,
-- liens, recherche, complétion LSP) ; render-markdown.nvim garde le rendu visuel.

local vault = vim.fn.expand("~/notes")

-- Nom du projet courant : basename de la racine git, sinon basename du cwd.
local function project_name()
  local root = vim.fs.root(0, ".git")
  if root and root ~= "" then
    return vim.fn.fnamemodify(root, ":t")
  end
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

local function note_path()
  return vault .. "/projects/" .. project_name() .. ".md"
end

-- Crée la note avec un template minimal si elle n'existe pas encore.
local function ensure_note(path)
  if vim.fn.filereadable(path) == 1 then
    return
  end
  vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p")
  local name = vim.fn.fnamemodify(path, ":t:r")
  vim.fn.writefile({ "# " .. name, "", "## Todos", "- [ ] ", "", "## Notes", "" }, path)
end

-- Pose/remplace la priorité (#A/#B/#C) sur la tâche courante.
local function set_priority(tag)
  local line = vim.api.nvim_get_current_line()
  line = line:gsub("%s*#[ABC]%f[%W]", "") -- retire une prio existante
  line = line:gsub("%s+$", "")
  vim.api.nvim_set_current_line(line .. " #" .. tag)
end

-- Coloration de toute la ligne d'une tâche selon sa priorité (#A/#B/#C).
-- Extmarks `line_hl_group` : buffer-local, donc fiable dans le flottant comme en
-- édition directe (contrairement à matchadd qui est par fenêtre). Fonds rose-pine discrets.
vim.api.nvim_set_hl(0, "NotePrioA", { bg = "#3a2733" }) -- teinte love
vim.api.nvim_set_hl(0, "NotePrioB", { bg = "#3a3327" }) -- teinte gold
vim.api.nvim_set_hl(0, "NotePrioC", { bg = "#26363a" }) -- teinte foam

local prio_ns = vim.api.nvim_create_namespace("note_prio")
local prio_groups = { A = "NotePrioA", B = "NotePrioB", C = "NotePrioC" }

local function refresh_prio(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return
  end
  vim.api.nvim_buf_clear_namespace(buf, prio_ns, 0, -1)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  for i, line in ipairs(lines) do
    local tag = line:match("#([ABC])%f[%W]") or line:match("#([ABC])$")
    if tag then
      vim.api.nvim_buf_set_extmark(buf, prio_ns, i - 1, 0, {
        line_hl_group = prio_groups[tag],
      })
    end
  end
end

vim.api.nvim_create_autocmd({ "BufWinEnter", "TextChanged", "TextChangedI", "InsertLeave" }, {
  pattern = "*.md",
  callback = function(ev)
    if vim.api.nvim_buf_get_name(ev.buf):find(vault, 1, true) then
      refresh_prio(ev.buf)
    end
  end,
})

local function save_buf(buf)
  if buf and vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified then
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! write")
    end)
  end
end

local float -- snacks.win courant (ou nil)

-- Ouvre/ferme la note du projet courant dans une fenêtre flottante.
local function toggle_note()
  if float and float:valid() then
    save_buf(float.buf)
    float:close()
    float = nil
    return
  end

  local path = note_path()
  ensure_note(path)

  -- Charger nous-mêmes le buffer (un `file=` passé à Snacks.win serait read-only).
  local buf = vim.fn.bufadd(path)
  vim.fn.bufload(buf)
  vim.bo[buf].buflisted = true

  float = Snacks.win({
    buf = buf,
    position = "float",
    border = "rounded",
    title = " " .. project_name() .. " ",
    title_pos = "center",
    width = 0.8,
    height = 0.8,
    enter = true,
    wo = { winbar = "" },
    keys = { q = "close" },
    on_win = function(self)
      -- Auto-save dès qu'on quitte le buffer de la note.
      vim.api.nvim_create_autocmd({ "BufLeave", "WinClosed" }, {
        buffer = self.buf,
        callback = function()
          save_buf(self.buf)
        end,
      })
    end,
    on_close = function()
      float = nil
    end,
  })
end

return {
  "obsidian-nvim/obsidian.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = "markdown",
  cmd = "Obsidian",
  keys = {
    { "<leader>nn", toggle_note, desc = "Note du projet (flottant)" },
    { "<leader>nx", "<cmd>Obsidian toggle_checkbox<cr>", desc = "Toggle checkbox", ft = "markdown" },
    { "<leader>nf", "<cmd>Obsidian quick_switch<cr>", desc = "Parcourir les notes" },
    { "<leader>ns", "<cmd>Obsidian search<cr>", desc = "Rechercher dans les notes" },
    { "<leader>na", function() set_priority("A") end, desc = "Priorité A (haute)", ft = "markdown" },
    { "<leader>nz", function() set_priority("B") end, desc = "Priorité B (moyenne)", ft = "markdown" },
    { "<leader>ne", function() set_priority("C") end, desc = "Priorité C (basse)", ft = "markdown" },
  },
  opts = {
    legacy_commands = false,
    workspaces = {
      { name = "notes", path = vault },
    },
    notes_subdir = "projects",
    new_notes_location = "notes_subdir",
    -- render-markdown.nvim s'occupe du rendu ; on désactive l'UI d'obsidian.
    ui = { enable = false },
    -- Notes simples : pas de frontmatter YAML imposé.
    frontmatter = { enabled = false },
    picker = { name = "snacks.picker" },
    completion = { min_chars = 2 },
    -- Toggle simple [ ] <-> [x] (pas d'états intermédiaires).
    checkbox = { order = { " ", "x" } },
  },
}
