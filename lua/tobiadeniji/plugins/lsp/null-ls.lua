-- Import null-ls safely
local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  return
end

local formatting = null_ls.builtins.formatting

-- Create a dedicated augroup
local lsp_format_augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = false, -- Set to true if you need to troubleshoot
  sources = {
    formatting.rubocop.with({
      command = "bundle",
      args = {
        "exec", "rubocop",
        "--auto-correct-all",
        "--stdin",
        "$FILENAME"
      },
      to_stdin = true,
      condition = function(utils)
        return utils.root_has_file({ ".rubocop.yml", "Gemfile" })
      end
    }),
    -- Add other formatters as needed
  },

  on_attach = function(client, bufnr)
    if client.name == "null-ls" then
      -- First clear any existing autocommands for this buffer
      vim.api.nvim_clear_autocmds({
        group = lsp_format_augroup,
        buffer = bufnr
      })

      -- Then create our formatting autocommand
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_format_augroup,
        buffer = bufnr,
        callback = function()
          -- Use null-ls formatting directly
          require("null-ls").format({
            bufnr = bufnr,
            filter = function(cl)
              return cl.name == "null-ls"
            end,
            async = false -- Important for write operations
          })
        end
      })
    end
  end
})
