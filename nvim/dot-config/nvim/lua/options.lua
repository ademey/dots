require "nvchad.options"

-- add yours here!

local o = vim.o
local opt = vim.opt
o.cursorline = true
o.cursorlineopt = 'both' -- to enable cursorline!

o.relativenumber = true

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2

-- last line not right?
opt.fillchars = { eob = "~", lastline = "&" }

-- Numbers 
o.ruler = true -- ??




