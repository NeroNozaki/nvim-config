local Util = require("red-ash.util")

local M = {}

---@param opts? red-ash.Config
function M.setup(opts)
  opts = require("red-ash.config").extend(opts)

  -- Base palette
  ---@class red-ash.Palette
  local colors = {
    bg = "#1c1c1c",
    surface = "#262626",
    highlight = "#2A2A2A",
    selection = "#484848",
    border = "#484848",
    muted = "#545454",
    fg = "#D4D4D4",
    white = "#e4e6e7",
    white_bright = "#F0F0F0",
    red = "#df5b61",
    red_dark = "#B83A48",
    red_bright = "#B85C68",
    green = "#55C878",
    green_bright = "#7BE495",
    yellow = "#E6B800",
    yellow_bright = "#ffd700",
    yellow_faint = "#e0d8ba",
    blue = "#82aaff",
    blue_bright = "#128aed",
    purple = "#B18ADB",
    purple_bright = "#C9A8EB",
    cyan = "#36C9B0",
    cyan_bright = "#4DD9E8",
    orange = "#E87545",
    pink = "#f973f0",
  }

  Util.bg = colors.bg
  Util.fg = colors.fg

  colors.none = "NONE"

  -- Derived colors (same idea as TokyoNight)
  colors.bg_dark = colors.surface
  colors.bg_highlight = colors.highlight
  colors.bg_visual = colors.selection
  colors.bg_search = colors.red_bright
  colors.fg_dark = colors.muted
  colors.fg_gutter = colors.muted

  -- Configurable backgrounds
  colors.bg_sidebar = opts.styles.sidebars == "transparent" and colors.none
    or opts.styles.sidebars == "dark" and colors.surface
    or colors.bg

  colors.bg_float = opts.styles.floats == "transparent" and colors.none
    or opts.styles.floats == "dark" and colors.surface
    or colors.bg

  colors.bg_popup = colors.surface
  colors.bg_statusline = colors.surface

  colors.fg_sidebar = colors.fg
  colors.fg_float = colors.fg

  -- Semantic
  colors.error = colors.red
  colors.warning = colors.yellow
  colors.info = colors.blue
  colors.hint = colors.cyan
  colors.todo = colors.yellow

  -- Diff
  colors.diff = {
    add = Util.blend_bg(colors.green, 0.15),
    change = Util.blend_bg(colors.yellow, 0.15),
    delete = Util.blend_bg(colors.red, 0.15),
    text = Util.blend_bg(colors.red_bright, 0.25),
  }

  -- Git
  colors.git = {
    add = colors.green,
    change = colors.yellow,
    delete = colors.red,
  }

  -- Terminal ANSI colors
  colors.terminal = {
    black = colors.bg,
    black_bright = colors.muted,
    red = colors.red,
    red_bright = colors.red_bright,
    green = colors.green,
    green_bright = colors.green_bright,
    yellow = colors.yellow,
    yellow_bright = colors.yellow_bright,
    blue = colors.blue,
    blue_bright = colors.blue_bright,
    magenta = colors.purple,
    magenta_bright = colors.purple_bright,
    cyan = colors.cyan,
    cyan_bright = colors.cyan_bright,
    white = colors.fg,
    white_bright = colors.white_bright,
  }

  -- User override hook
  opts.on_colors(colors)

  return colors
end

return M
