-- cmp-nvim-lsp
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap

local on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
	keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)

	-- keep only if you still use a plugin exposing these commands
	if client.name == "tsserver" or client.name == "ts_ls" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>", opts)
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>", opts)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>", opts)
	end
end

local capabilities = cmp_nvim_lsp.default_capabilities()

vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.HINT] = "ﴞ",
			[vim.diagnostic.severity.INFO] = "",
		},
	},
	virtual_text = true,
	update_in_insert = false,
	severity_sort = true,
})

vim.lsp.config("gopls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		gopls = {
			analyses = {
				assign = true,
				atomic = true,
				bools = true,
				composite = true,
				copylocks = true,
				deepequalerrors = true,
				embed = true,
				errorsas = true,
				fieldalignment = true,
				httpresponse = true,
				ifaceassert = true,
				loopclosure = true,
				lostcancel = true,
				nilfunc = true,
				nilness = true,
				nonewvars = true,
				printf = true,
				shadow = true,
				shift = true,
				simplifycompositelit = true,
				simplifyrange = true,
				simplifyslice = true,
				sortslice = true,
				stdmethods = true,
				stringintconv = true,
				structtag = true,
				tests = true,
				timeformat = true,
				unmarshal = true,
				unreachable = true,
				unsafeptr = true,
				unusedparams = true,
				unusedresult = true,
				useany = true,
			},
			completeUnimported = true,
			hoverKind = "FullDocumentation",
			linkTarget = "pkg.go.dev",
			usePlaceholders = true,
			vulncheck = "Imports",
		},
	},
})

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

vim.lsp.config("solargraph", {
	capabilities = capabilities,
	on_attach = on_attach,
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local root = vim.fs.dirname(vim.fs.find({ "Gemfile", ".git" }, {
			upward = true,
			path = fname,
		})[1])

		on_dir(root or vim.fn.getcwd())
	end,
	settings = {
		solargraph = {
			diagnostics = true,
			formatting = true,
			useBundler = true,
			logLevel = "warn",
			transport = "stdio",
			checkGemVersion = false,
		},
	},
})

-- custom server not shipped by default
vim.lsp.config("helm_ls", {
	cmd = { "helm_ls", "serve" },
	filetypes = { "helm" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local chart = vim.fs.find("Chart.yaml", { upward = true, path = fname })[1]
		on_dir(chart and vim.fs.dirname(chart) or nil)
	end,
})

vim.lsp.enable("gopls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("solargraph")
vim.lsp.enable("helm_ls")
