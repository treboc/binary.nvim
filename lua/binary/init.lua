-- Configuration pattern reference from https://github.com/folke/tokyonight.nvim?tab=readme-ov-file (Apache 2.0 License)
local config = require("binary.config")

local M = {}

function M.load(opts)
  opts = require("binary.config").extend(opts)

  local system_bg = vim.o.background
  print(system_bg)
  local style_bg = opts.style
  if opts.style == "system" then
    opts = require("binary.config").extend({ style = system_bg })
  else
    if style_bg ~= "dark" then
      style_bg = "light"
    end
  end

  if system_bg ~= style_bg then
    vim.g.background = style_bg
  end

  return require("binary.theme").setup(opts)
end

M.setup = config.setup

return M
