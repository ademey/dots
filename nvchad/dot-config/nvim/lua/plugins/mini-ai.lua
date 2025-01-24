return {
  "echasnovski/mini.nvim",
  version = "*",
  lazy = false,
  init = function()
    local miniai = require "mini.ai"

    miniai.setup()
  end,
}
