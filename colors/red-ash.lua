-- Entry point for :colorscheme red-ash
require("red-ash").setup({
  transparent = true,
  styles = {
    comments = { italic = true },
    keywords = {},
  },
  -- on_colors = function(colors)
  --   -- mutate any color here
  -- end,
  -- on_highlights = function(highlights, colors)
  --   -- mutate any highlight group here
  -- end,
})
require("red-ash").load()
