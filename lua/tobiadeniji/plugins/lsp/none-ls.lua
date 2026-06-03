local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  return
end

local formatting = null_ls.builtins.formatting
local lsp_format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = false,
  sources = {
    formatting.rubocop.with({
      command = "bundle",
      args = {
        "exec",
        "rubocop",
        "--auto-correct-all",
        "--stdin",
        "$FILENAME",
      },
      to_stdin = true,
      condition = function(utils)
        return utils.root_has_file({ ".rubocop.yml", "Gemfile" })
      end,
    }),
  },

  on_attach = function(client, bufnr)
    if client.name == "null-ls" then
      vim.api.nvim_clear_autocmds({
        group = lsp_format_augroup,
        buffer = bufnr,
      })

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_format_augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            bufnr = bufnr,
            filter = function(cl)
              return cl.name == "null-ls"
            end,
            async = false,
          })
        end,
      })
    end
  end,
})
