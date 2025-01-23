require "nvchad.options"


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


vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local bufs = vim.t.bufs
    if #bufs == 1 and vim.api.nvim_buf_get_name(bufs[1]) == "" then
      vim.cmd "Nvdash"
    end
  end,
})
