-- Toast in this Neovim when a Claude Code session in another tmux window needs
-- input or finishes a task. Published plugin: https://github.com/Popoch39/claude-tmux-notify.nvim
-- The Claude Code hook lives in ~/.claude/settings.json -> ~/.claude/hooks/tmux-notify.sh
-- (or run :ClaudeTmuxNotifyInstallHook to (re)install it).
return {
  "Popoch39/claude-tmux-notify.nvim",
  event = "VeryLazy",
  opts = {},
}
