return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- lua
        null_ls.builtins.formatting.stylua,
        -- html, js, css
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.diagnostics.eslint,
        -- python
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort
      }
    })

    vim.keymap.set("n", "<C-S-f>", vim.lsp.buf.format, {})
  end
}
