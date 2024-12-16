return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server", -- works
        "stylua", -- works
        "html-lsp",
        "css-lsp", -- workd
        "prettier",
        "ts_ls", -- works but not cus included here
        "tailwindcss-language-server",
        "eslint-lsp",
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "javascript",
      "javascriptreact",
      "jsx",
      "tsx",
      "typescript",
      "typescriptreact",
      "vue",
      "xml",
    },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  -- {
  --   "shaun-mathew/Chameleon.nvim",
  --   lazy = false,
  --   config = function()
  --     require("chameleon").setup()
  --   end,
  -- },
  -- {
  --   "lovesegfault/beautysh",
  --   config = function()
  --     require "configs.beautysh"
  --   end,
  -- }
}
