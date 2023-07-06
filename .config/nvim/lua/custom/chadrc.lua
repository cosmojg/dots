local M = {}

M.plugins = "custom.plugins"

M.ui = {
  theme_toggle = {"catppuccin", "catppuccin_latte"},
  theme = "catppuccin",
}

M.mappings = require "custom.mappings"

return M
