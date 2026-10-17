local M = {}

---@param c table colors
---@param opts red-ash.Config
function M.get(c, opts)
  return {
    GitSignsAdd = { fg = c.git.add },
    GitSignsChange = { fg = c.git.change },
    GitSignsDelete = { fg = c.git.delete },
    GitSignsAddNr = { fg = c.git.add },
    GitSignsChangeNr = { fg = c.git.change },
    GitSignsDeleteNr = { fg = c.git.delete },
    GitSignsAddLn = { bg = c.diff.add },
    GitSignsChangeLn = { bg = c.diff.change },
    GitSignsDeleteLn = { bg = c.diff.delete },
  }
end

return M
