require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
-- Cool but caused typing errors
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- set terminal colorscheme automatically
-- https://www.reddit.com/r/neovim/comments/w6qh8x/is_there_are_way_to_automagically_translate_my/
local function autoscheme()
  vim.cmd "e $HOME/k.conf"
  vim.api.nvim_win_set_cursor(0, { 1, 0 })
  -- vim.cmd("/autoscheme")
  local c = vim.api.nvim_get_hl_by_name("Keyword", true)

  local ln = unpack(vim.api.nvim_win_get_cursor(0))
  local bg = ("#%06x"):format(vim.api.nvim_get_hl_by_name("Normal", true).background)
  local fg = ("#%06x"):format(vim.api.nvim_get_hl_by_name("Normal", true).foreground)
  -- print(vim.inspect(c))
  -- local color1 = ("#%06x"):format(vim.api.nvim_get_hl(0, { name = "Normal" }).foreground)
  vim.api.nvim_buf_set_lines(0, ln, ln + 3, false, {
    "background " .. bg .. "",
    "foreground " .. fg .. "",
    -- "cursor" .. vim.g.terminal_color_12 .. "",
    "cursor #cccc",
    "thre #44475a",
    "four #000000",
  })
  vim.cmd "w | noh | bd"
end

-- local function testscheme()
--   local theme_color = vim.api.nvim_get_hl(0, { name = "Normal" })
--   vim.pretty_print("nvim_set_hl not-normal", vim.api.nvim_get_hl_by_name("Normal", false))
--   -- print(vim.inspect(theme_color))
-- end

vim.keymap.set("n", "<leader>ct", autoscheme, { silent = true, desc = "Set terminal colorscheme" })
-- vim.keymap.set("n", "<leader>ct", testscheme, { silent = true, desc = "Set terminal colorscheme" })
