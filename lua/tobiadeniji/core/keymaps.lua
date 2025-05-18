-- set leader key to space
vim.g.mapleader = " "

-- Leave 12 lines before EOL while scrolling
vim.opt.scrolloff = 6

-- incremental search
vim.opt.incsearch = true

-- Cleanup nightflyWinSeparator
-- https://github.com/bluz71/vim-nightfly-colors#nightflywinseparator
vim.g.nightflyWinSeparator = 2
vim.opt.fillchars = {
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}

-- Remove trailing tilde (~) signs from unused buffers
vim.opt.fillchars:append({ eob = " " })

-- for conciseness
local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------

-- use jj to exit insert mode
keymap.set("i", "jj", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>c", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- Toggle auto-save
keymap.set("n", "<leader>aa", ":ASToggle<CR>") -- toggle auto save buffer

-- alpha-vim
keymap.set("n", "<leader>a", ":Alpha<CR>") -- toggle alpha-vim home screen

-- nvim buffer manipulations
keymap.set("n", "<leader>q", ":wqa!<CR>") -- write buffer to file and close neovim
keymap.set("n", "<leader>w", ":w<CR>") -- write buffer to file only

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>") -- make file explorer active
keymap.set("n", "<leader>x", ":setlocal rnu<CR>") -- toggle line numbers in file explorer
keymap.set("n", "<leader>y", ":setlocal nornu<CR>") -- toggle line numbers in file explorer

-- Git blame
keymap.set("n", "<leader>b", ":GitBlameToggle<CR>") -- toggle git blame on line

-- Gitsigns, show recent changes
keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>") -- toggle gitsigns preview_hunk

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
keymap.set("n", "<leader>n", "<cmd>Telescope noice<cr>") -- list all noice notifications

-- telescope git commands (not on youtube nvim video)
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" for git status]

-- restart lsp server (not on youtube nvim video)
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary

-- move code block
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- run toggleterm
keymap.set("n", "<leader>mm", ":lua require('toggleterm').setup()<CR>")
keymap.set("n", "<leader>m", ":ToggleTerm<CR>")

-- append line below to current line
keymap.set("n", "J", "mzJ`z")

--------------------------------------------------------------
--  My Other Custom Mappings (this might get a little messy!)
--------------------------------------------------------------
keymap.set("n", "<A-Down>", "}")
keymap.set("n", "<A-Up>", "{")
keymap.set("i", "<A-Down>", "<C-\\><C-O>}")
keymap.set("i", "<A-Up>", "<C-\\><C-O>{")

keymap.set("n", "<C-r>", "r")

-- move back and forward with by a word.
keymap.set("n", "<A-Left>", "b")
keymap.set("n", "<A-Right>", "w")
keymap.set("v", "<A-Left>", "b")
keymap.set("v", "<A-Right>", "w")
keymap.set("i", "<A-Left>", "<C-\\><C-O>b")
keymap.set("i", "<A-Right>", "<C-\\><C-O>w")

keymap.set("i", "<C-Left>", "<C-\\><C-O>0")
keymap.set("i", "<C-Right>", "<C-\\><C-O>$")

keymap.set("n", "<C-Left>", "0")
keymap.set("n", "<C-Right>", "$")

keymap.set("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})

-- Run normal mode cmds in insert mode
-- keymap.set("i", "<leader>o", "<C-o>")

-- Delete to beginning of line in insert mode
-- keymap.set("i", "<leader>u", "<C-u>")

-- Delete word in insert mode
-- keymap.set("i", "<leader>w", "<C-w>")

-- remapped } and { for faster scrolling 
