return {
  cmp = {
    style = "atom_colored"
  },

  statusline = {
    enabled = true,
    theme = "minimal",
    separator_style = "block",
  },

  tabufline = {
    lazyload = false,
    order = { "treeOffset", "buffers", "tabs", "btns" },
  },

  telescope = { style = "borderless" }, -- borderless / bordered
}
