require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local undo = vim.keymap.del

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Line numbers
undo("n", "<leader>n")
undo("n", "<leader>rn")
map("n", "<leader>ln", "<cmd>set nu!<CR>", { desc = "toggle line number" })
map("n", "<leader>lr", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })

-- Tree
undo("n", "<C-n>")
undo("n", "<leader>e")

map("n", "<leader>ee", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" }) -- toggle file explorer
map("n", "<leader>ex", "<cmd>NvimTreeClose<CR>", { desc = "Close file explorer" }) -- toggle file explorer
map("n", "<leader>e+", "<cmd>NvimTreeResize +10<CR>", { desc = "Increase file explorer size" }) -- toggle file explorer
map("n", "<leader>e-", "<cmd>NvimTreeResize -10<CR>", { desc = "Decrease file explorer size" }) -- toggle file explorer
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- Tab switching with tab
undo("n", "<tab>")
undo("n", "<S-tab>")
