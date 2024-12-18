-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "chadracula",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.nvdash = {
  load_on_startup = true,
  header = {
    "      .-'~~~-.           ",
    "    .'o  oOOOo`.         ",
    "   :~~~-.oOo   o`.       ",
    "    `. @ ~-.  oOOo.      ",
    "      `.; / ~.  OO:      ",
    "      .'  ;-- `.o.'      ",
    "     ,'  ; ~~--'~        ",
    "     ;  ;                ",
    "___\\;_\\//___[|]________",
    "                         ",
  },

  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        -- return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
        return "Mag ik je virtueel beffen?"
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    { txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
  },
}

-- https://www.reddit.com/r/neovim/comments/1fqole3/comment/lpvenci/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
-- TODO: Test deleting this config
M.mason = {
  pkgs = {
    "lua-language-server",
    "stylua",
    "html-lsp",
    "css-lsp",
    "prettier",
    "beautysh",
  },
}

return M
