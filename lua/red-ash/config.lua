local M = {}

---@class red-ash.Config
---@field on_colors fun(colors: table)
---@field on_highlights fun(highlights: table, colors: table)
M.defaults = {
  transparent = false, -- Disable background color
  terminal_colors = true, -- Set terminal ANSI colors
  styles = {
    comments = { italic = true },
    keywords = {},
    functions = {},
    variables = {},
    sidebars = "transparent", -- "dark" | "transparent" | "normal"
    floats = "transparent", -- "dark" | "transparent" | "normal"
  },
  dim_inactive = false,
  -- Called after the color palette is built. Mutate colors here.
  on_colors = function(colors) end,
  -- Called after highlight groups are generated. Mutate highlights here.
  on_highlights = function(highlights, colors) end,
  -- Plugin support: "all" loads everything, or list specific ones.
  -- When using lazy.nvim, set auto = true to only load installed plugins.
  plugins = {
    -- all = package.loaded.lazy == nil,
    all = true,
    auto = true,
  },
}

---@type red-ash.Config
M.options = nil

---@param options? red-ash.Config
function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

---@param opts? red-ash.Config
function M.extend(opts)
  return opts and vim.tbl_deep_extend("force", {}, M.options or M.defaults, opts)
    or (M.options or M.defaults)
end

setmetatable(M, {
  __index = function(_, k)
    if k == "options" then
      return M.defaults
    end
  end,
})

return M
