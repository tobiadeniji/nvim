-- Import none-ls safely
local null_ls_ok, null_ls = pcall(require, "none-ls")
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
      -- Clear existing autocommands
      vim.api.nvim_clear_autocmds({
        group = lsp_format_augroup,
        buffer = bufnr
      })

      -- Create formatting autocommand
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_format_augroup,
        buffer = bufnr,
        callback = function()
          -- Use none-ls formatting directly
          require("none-ls").format({
            bufnr = bufnr,
            filter = function(cl)
              return cl.name == "null-ls"
            end,
            async = false
          })
        end
      })
    end
  end
})

