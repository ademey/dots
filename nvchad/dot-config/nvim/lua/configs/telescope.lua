local options = {
  defaults = {
    file_ignore_patterns = {
      "node_modules/",
      ".git/",
      "dist/",
      "build/",
    },
  },
  pickers = {
    live_grep = {
      additional_args = function()
        return {"--hidden"}  -- Include hidden files
      end,
    },
  },
}

return options