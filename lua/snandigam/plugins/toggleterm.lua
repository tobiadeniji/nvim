require("toggleterm").setup({
	size = 20, -- Set default size for terminal windows
	open_mapping = [[<c-\>]], -- Define your own keybinding to open/close terminal
	hide_numbers = true, -- Hide line numbers in terminal windows
	shade_filetypes = {},
	shade_terminals = true, -- Shade the terminal window
	start_in_insert = true, -- Open terminal in insert mode
	insert_mappings = true, -- Enable insert mode mappings
	persist_size = true, -- Keep the terminal size between sessions
	direction = "float", -- Can be 'horizontal', 'vertical', or 'float'
	float_opts = {
		border = "curved", -- Options: 'none', 'single', 'double', 'shadow', etc.
		width = 120, -- Set the width of the floating window
		height = 30, -- Set the height of the floating window
		winblend = 2, -- Transparency level (0 is fully opaque, 100 is fully transparent)
	},
	close_on_exit = true, -- Close the terminal when the process exits
})

-- :lua require('toggleterm').setup()
