local M = {}

M.bg = "#1c1c1c"
M.fg = "#D4D4D4"

---@param c string hex color
local function rgb(c)
  c = string.lower(c)
  return {
    tonumber(c:sub(2, 3), 16),
    tonumber(c:sub(4, 5), 16),
    tonumber(c:sub(6, 7), 16),
  }
end

---Blend foreground over background by alpha (0 = bg, 1 = fg)
---@param foreground string
---@param alpha number|string
---@param background string?
function M.blend(foreground, alpha, background)
  alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
  local bg = rgb(background or M.bg)
  local fg = rgb(foreground)

  local function channel(i)
    local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02x%02x%02x", channel(1), channel(2), channel(3))
end

function M.blend_bg(hex, amount, bg)
  return M.blend(hex, amount, bg or M.bg)
end

function M.blend_fg(hex, amount, fg)
  return M.blend(hex, amount, fg or M.fg)
end

---Expand style = { italic = true } tables into the highlight definition
---@param groups table
function M.resolve(groups)
  for _, hl in pairs(groups) do
    if type(hl) == "table" and type(hl.style) == "table" then
      for k, v in pairs(hl.style) do
        hl[k] = v
      end
      hl.style = nil
    end
  end
  return groups
end

return M
