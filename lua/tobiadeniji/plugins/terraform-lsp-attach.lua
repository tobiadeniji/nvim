vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

    if client and client.name == "terraformls" and ft == "terraform" then
      vim.schedule(function()
        vim.bo[bufnr].commentstring = "# %s"
        vim.notify("Overriding terraform commentstring to # %s", vim.log.levels.INFO)
      end)
    end
  end,
})
