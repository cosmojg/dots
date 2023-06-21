local M = {}

M.general = {
  n = {
    [";"] = { ":", "command mode", opts = { nowait = true } },
  },

  i = {
    -- ["jk"] = { "<ESC>", "escape vim" },
  },
}

return M
