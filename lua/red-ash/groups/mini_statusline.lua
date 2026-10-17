local M = {}

---@param c table colors
---@param opts red-ash.Config
function M.get(c, opts)
  return {
    MiniStatuslineModeNormal = { fg = c.bg, bg = c.red, bold = true },
    MiniStatuslineModeInsert = { fg = c.bg, bg = c.green, bold = true },
    MiniStatuslineModeCommand = { fg = c.bg, bg = c.blue, bold = true },
    MiniStatuslineModeVisual = { fg = c.bg, bg = c.purple, bold = true },
    MiniStatuslineModeReplace = { fg = c.bg, bg = c.orange, bold = true },
    MiniStatuslineModeOther = { fg = c.bg, bg = c.cyan, bold = true },
    MiniStatuslineDevinfo = { fg = c.fg, bg = c.surface },
    MiniStatuslineFilename = { fg = c.fg, bg = c.surface },
    MiniStatuslineFileinfo = { fg = c.fg, bg = c.surface },
    MiniStatuslineInactive = { fg = c.muted, bg = c.bg },
  }
end

return M
