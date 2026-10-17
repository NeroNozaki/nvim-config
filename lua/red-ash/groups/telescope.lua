local M = {}

---@param c table colors
---@param opts red-ash.Config
function M.get(c, opts)
  return {
    TelescopeNormal = { fg = c.fg, bg = c.bg_float },
    TelescopeBorder = { fg = c.border, bg = c.bg_float },
    TelescopeTitle = { fg = c.border, bg = c.bg_float },
    TelescopePromptNormal = { fg = c.fg, bg = c.bg_float },
    TelescopePromptBorder = { fg = c.border, bg = c.bg_float },
    TelescopePromptTitle = { fg = c.red, bg = c.bg_float },
    TelescopePreviewTitle = { fg = c.blue, bg = c.bg_float },
    TelescopeResultsTitle = { fg = c.green, bg = c.bg_float },
    TelescopeMatching = { fg = c.yellow, bold = true },
    TelescopeSelection = { bg = c.surface },
    TelescopeSelectionCaret = { fg = c.red, bg = c.surface },
  }
end

return M
