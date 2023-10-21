-- local opts = {
-- 	log_level = "info",
-- 	auto_session_enable_last_session = false,
-- 	auto_session_root_dir = vim.fn.stdpath("data") .. "~/.auto-session/",
-- 	auto_session_enabled = true,
-- 	auto_save_enabled = nil,
-- 	auto_restore_enabled = nil,
-- 	auto_session_suppress_dirs = { "~/", "/", "~/Downloads", "~/Documents/", "~/Desktop/", "~/Movies/", "~/Books/" },
-- 	auto_session_use_git_branch = nil,
-- 	-- the configs below are lua only
-- 	bypass_session_save_file_types = nil,
-- }

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- require("auto-session").setup(opts)

-- Auto-session setup example
require("auto-session").setup({
	-- Session management options
	log_level = "info", -- The log level. Can be 'debug', 'info', 'warn', or 'error'
	auto_session_enabled = true, -- Enable or disable auto-session
	auto_session_create_enabled = true, -- Automatically create sessions when opening Neovim
	auto_session_use_git_branch = true, -- Use the current Git branch name as session name (if in a Git repo)
	auto_session_suppress_dirs = { "~/", "~/Projects", "/tmp" }, -- Ignore certain directories for session saving
	auto_session_save_on_exit = true, -- Save session when Neovim exits
	auto_session_restore_on_cwd_change = true, -- Restore session when changing directories
	auto_session_restore_on_open = true, -- Restore session when opening Neovim

	-- Session options (what to save and restore)
	session_lens = {
		path_display = { "shorten" },
	},

	-- Session file path and naming
	session_directory = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions"), -- Path where sessions will be stored
	session_file_prefix = "Session_", -- Prefix for session file names
	auto_session_restore = true, -- Automatically restore sessions on startup
	-- session_filetype = 'json',  -- You can choose 'json' or 'vim' as session file format (default: 'vim')

	-- Specific session options for saving/restoring
	sessionoptions = {
		"buffers", -- Save all open buffers
		"curdir", -- Save the current working directory
		"tabpages", -- Save tab pages (tabs)
		"winsize", -- Save window size
		"localoptions", -- Save local options like window splits and buffer settings
	},

	-- On load session callback
	pre_save_cmds = { -- Commands to run before saving the session
		'echo "Session saving..."',
	},
	post_save_cmds = { -- Commands to run after saving the session
		'echo "Session saved!"',
	},
	pre_restore_cmds = { -- Commands to run before restoring the session
		'echo "Restoring session..."',
	},
	post_restore_cmds = { -- Commands to run after restoring the session
		'echo "Session restored!"',
	},

	-- Optional: Prevent saving sessions for certain directories
	session_ignore_patterns = { "node_modules", ".git", "build", "dist" }, -- These patterns are ignored when saving a session

	-- When restoring, specify whether to use the last session or the session based on the current directory
	use_last_session = false, -- Set this to true if you want to use the last session automatically on startup
})
