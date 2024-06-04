local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "css",
    "fish",
    "html",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "regex",
    "tsx",
    "typescript",
    "vim",
  },
  sync_install = false,
  auto_install = true,
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- python stuff
    "pylsp",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.nvimmagic = {
  model = "gpt-4o",
}

return M
