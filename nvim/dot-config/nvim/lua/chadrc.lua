-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

-- see if the file exists
local function file_exists(file)
  local f = io.open(file, "rb")
  if f then
    f:close()
  end
  return f ~= nil
end

-- get all lines from a file, returns an empty
-- list/table if the file does not exist
local function lines_from(file)
  if not file_exists(file) then
    return {}
  end
  local lines = {}
  for line in io.lines(file) do
    lines[#lines + 1] = line
  end
  return lines
end

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "oxocarbon",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
}

M.ui = {
  statusline = {
    enabled = true,
    theme = "minimal",
    separator_style = "block",
  },
}

M.nvdash = {
  load_on_startup = true,
  header = function()
    -- local pic = lines_from "/home/anne/Notes/today.md"
    local pic = lines_from "/home/anne/Notes/ascii/mushroom-2.ascii"
    -- local img = {}
    -- for k, v in pairs(pic) do
    --   img[k] = v
    -- end
    return pic
  end,
  buttons = {
    { txt = "  Find File", keys = "ff", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "fo", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "fw", cmd = "Telescope live_grep" },
    { txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },

    { txt = ".", hl = "NvDashFooter", no_gap = true, rep = true },

    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    {
      txt = function()
        local handle = io.popen "echo 'Do a bash thing'"
        local result = handle:read "*a"
        handle:close()
        return result
      end,
      hl = "NvDashFooter",
      no_gap = true,
    },

    {
      txt = ".",
      hl = "NvDashFooter",
      no_gap = false,
      rep = true,
    },
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
