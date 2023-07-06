local overrides = require "custom.overrides"

return {

  -- override default plugins
  { "nvim-tree/nvim-tree.lua", opts = overrides.nvimtree },
  { "nvim-treesitter/nvim-treesitter", opts = overrides.treesitter },

  -- configure custom plugins
  {
    "ricardicus/nvim-magic",
    config = function()
      require("nvim-magic").setup()
    end,
    requires = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim'
    }
	},

  {
    "ojroques/nvim-osc52",
    config = function()
      local function copy(lines, _)
        require("osc52").copy(table.concat(lines, "\n"))
      end
      local function paste()
        return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
      end
      vim.g.clipboard = {
        name = "osc52",
        copy = { ["+"] = copy, ["*"] = copy },
        paste = { ["+"] = paste, ["*"] = paste },
      }
    end,
  },

  -- ["gpanders/editorconfig.nvim"] = {
  --   after = "indent-o-matic",
  -- },
  --
  -- ["Darazaki/indent-o-matic"] = {
  --   event = "InsertEnter",
  --   config = function()
  --     require("indent-o-matic").setup({
  --       max_lines = 256,
  --       standard_widths = { 2, 3, 4, 8 },
  --     })
  --   end,
  -- },
  --
  -- ["zbirenbaum/copilot.lua"] = {
  --   after = "nvim-lspconfig",
  --   config = function()
  --     vim.defer_fn(function()
  --       require("copilot").setup({
  --         copilot_node_command = "nodesixteen",
  --       })
  --     end, 100)
  --   end,
  -- },
  --
  -- ["zbirenbaum/neodim"] = {
  --   event = "LspAttach",
  --   config = function ()
  --     require("neodim").setup({
  --       alpha = 0.75,
  --       blend_color = "#000000",
  --       update_in_insert = {
  --         enable = true,
  --         delay = 100,
  --       },
  --       hide = {
  --         virtual_text = true,
  --         signs = true,
  --         underline = true,
  --       },
  --     })
  --   end,
  -- },
}
