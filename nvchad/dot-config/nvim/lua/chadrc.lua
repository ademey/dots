-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "rosepine",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    ["NvDashAscii"] = { fg = "sun" },
    ["NvDashFooter"] = { fg = "grey_fg" },
  },
}

M.nvdash = require "configs.nvdash"
M.ui = require "configs.ui"

M.cheatsheet = {
  theme = "simple",
  excluded_groups = {},
}

M.colorify = {
  enabled = true,
  mode = "bg",
}

M.mason = {
  pkgs = {
    "prettier",
    "eslint_d",
    "stylua",
    "pylint",
    "isort",
    "black",
  },
}

return M
