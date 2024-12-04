-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"lua_ls",
		"gopls",
		"golangci_lint_ls",
		"bashls",
		"dockerls",
		-- "helm-ls",
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = false, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"stylua", -- lua formatter
		"golangci_lint_ls",
		"gopls",
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
