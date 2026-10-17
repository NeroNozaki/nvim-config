local config = require("red-ash.config")

local M = {}

---@param opts? red-ash.Config
function M.setup(opts)
  config.setup(opts)
end

---@param opts? red-ash.Config
function M.load(opts)
  opts = config.extend(opts)
  return require("red-ash.theme").setup(opts)
end

return M
