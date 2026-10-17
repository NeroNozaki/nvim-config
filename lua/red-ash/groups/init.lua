local Util = require("red-ash.util")

local M = {}

-- Map of plugin name → group module name
M.plugins = {
  ["gitsigns.nvim"] = "gitsigns",
  ["telescope.nvim"] = "telescope",
  ["mini.statusline"] = "mini_statusline",
  -- Add more as you need them:
  -- ["nvim-cmp"] = "cmp",
  -- ["neo-tree.nvim"] = "neo-tree",
  -- ["which-key.nvim"] = "which-key",
}

function M.get_group(name)
  return require("red-ash.groups." .. name)
end

---@param name string
---@param colors table
---@param opts red-ash.Config
function M.get(name, colors, opts)
  local mod = M.get_group(name)
  return mod.get(colors, opts)
end

---@param colors table
---@param opts red-ash.Config
function M.setup(colors, opts)
  -- Always load these
  local groups = {
    base = true,
    treesitter = true,
  }

  -- Plugin groups
  if opts.plugins.all then
    for _, group in pairs(M.plugins) do
      groups[group] = true
    end
  elseif opts.plugins.auto and package.loaded.lazy then
    local plugins = require("lazy.core.config").plugins
    for plugin, group in pairs(M.plugins) do
      if plugins[plugin] then
        groups[group] = true
      end
    end
  end

  -- Merge all selected group modules
  local ret = {}
  for name in pairs(groups) do
    local ok, mod_groups = pcall(M.get, name, colors, opts)
    if ok then
      for k, v in pairs(mod_groups) do
        ret[k] = v
      end
    end
  end

  Util.resolve(ret)
  opts.on_highlights(ret, colors)

  return ret
end

return M
