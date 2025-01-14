local M = {}

M.defaults = {
  style = "system",
  lightColors = {
    fg = "#000000",
    bg = "#ffffff",
    force = true,
  },
  darkColors = {
    fg = "#ffffff",
    bg = "#000000",
    force = true,
  },
  lightSpecialColors = {
    fg = "#757575",
    bg = "#ffffff",
    force = true,
    italic = true,
  },
  darkSpecialColors = {
    fg = "#757575",
    bg = "#000000",
    force = true,
    italic = true,
  },
  reversed_group = {},
}

M.options = nil

function M.setup(options)
  M.options = vim.tbl_deep_extend("force", {}, M.defaults, options or {})
end

function M.extend(opts)
  return opts and vim.tbl_deep_extend("force", {}, M.options, opts) or M.options
end

setmetatable(M, {
  __index = function(_, k)
    if k == "options" then
      return M.defaults
    end
  end,
})

return M
