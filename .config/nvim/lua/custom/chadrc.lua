local M = {}

M.plugins = require "custom.plugins"

M.ui = {
  theme = "catppuccin",
  theme_toggle = {"catppuccin", "catppuccin_latte"},
}

M.options = {
  nvChad = {
    update_url = "https://github.com/NvChad/NvChad",
    update_branch = "main",
  },
}

M.mappings = require "custom.mappings"

return M
