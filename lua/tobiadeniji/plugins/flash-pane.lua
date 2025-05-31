local M = {}

-- Default configuration
local config = {
  duration = 300,  -- flash duration in milliseconds
  highlight = {
    bg = '#333333',
    fg = '#ffffff',
    gui = 'bold'
  }
}

function M.setup(user_config)
  config = vim.tbl_deep_extend('force', config, user_config or {})
end

function M.flash()
  local win = vim.api.nvim_get_current_win()
  local original_winhl = vim.wo[win].winhl
  -- Define highlight group
  vim.api.nvim_set_hl(0, 'FlashHighlight', {
    bg = config.highlight.bg,
    fg = config.highlight.fg,
    bold = config.highlight.gui:find('bold') ~= nil,
    underline = config.highlight.gui:find('underline') ~= nil,
    italic = config.highlight.gui:find('italic') ~= nil,
  })
  -- Apply highlight
  vim.wo[win].winhl = 'Normal:FlashHighlight,NormalNC:FlashHighlight'
  -- Clear after delay
  vim.defer_fn(function()
    vim.wo[win].winhl = original_winhl
  end, config.duration)
end

-- Create user command
vim.api.nvim_create_user_command('FlashPane', M.flash, {
  desc = 'Flash current window highlight'
})

return M
