local M = {}

function M.setup(opts)
  if vim.g.colors_name then
    vim.cmd("hi clear")
    vim.cmd("syntax reset")
  end
  vim.o.termguicolors = true
  vim.g.colors_name = "binary"

  local style = opts.style
  local colors = opts.colors
  local commentColors = opts.commentColors
  if style == "dark" then
    colors = {
      fg = colors.bg,
      bg = colors.fg,
      force = colors.force,
    }

    commentColors = {
      fg = commentColors.bg,
      bg = colors.fg,
      force = commentColors.force,
      italic = commentColors.italic,
    }
  end
  local reversed_colors = { fg = colors.bg, bg = colors.fg, force = true }

  local all_groups = vim.api.nvim_get_hl(0, {})
  for group, _ in pairs(all_groups) do
    if group and type(group) == "string" then
      local groupString = tostring(group):lower()
      if groupString:find("comment") then
        vim.api.nvim_set_hl(0, group, commentColors)
      elseif groupString:find("whitespace") then
        vim.api.nvim_set_hl(0, group, commentColors)
      else
        vim.api.nvim_set_hl(0, group, colors)
      end
    end
  end

  local reversed_group = require("binary.groups.reversed")
  for group, value in pairs(opts.reversed_group or {}) do
    reversed_group[group] = value
  end

  for group, value in pairs(reversed_group) do
    if value and group and type(group) == "string" then
      vim.api.nvim_set_hl(0, group, reversed_colors)
    end
  end

  return colors, all_groups, opts
end

return M
