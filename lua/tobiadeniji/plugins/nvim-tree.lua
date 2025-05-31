-- Safely import nvim-tree
local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
  return
end

-- Disable netrw (recommended by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Customize tree UI (colors, icons)
vim.cmd([[highlight NvimTreeIndentMarker guifg=#3FC5FF]])

-- Configure nvim-tree
nvimtree.setup({
  renderer = {
    icons = {
      glyphs = {
        folder = {
          arrow_closed = "", -- when folder is closed
          arrow_open = "",   -- when folder is open
        },
      },
    },
  },
  actions = {
    open_file = {
      window_picker = {
        enable = false, -- better experience with window splits
      },
    },
  },
  -- Uncomment this to disable git ignore filtering
  -- git = {
  --   ignore = false,
  -- },
})

local function open_nvim_tree(data)
  local is_no_name = data.file == "" and vim.bo[data.buf].buftype == ""
  local is_directory = vim.fn.isdirectory(data.file) == 1

  if not is_no_name and not is_directory then
    return
  end

  if is_directory then
    vim.cmd.cd(data.file)
  end

  require("nvim-tree.api").tree.open()
end

-- Uncomment this to enable the auto-open behavior
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = open_nvim_tree,
-- })
