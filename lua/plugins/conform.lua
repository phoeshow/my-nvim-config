vim.api.nvim_create_autocmd("BufWritePre", {
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
    require("conform").setup({
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = {
          -- c = true,
          -- cpp = true,
        }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
        end
      end,
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "oxfmt" },
        typescript = { "oxfmt" },
        javascriptreact = { "oxfmt" },
        typescriptreact = { "oxfmt" },
        markdown = { "oxfmt" },
        html = { "oxfmt" },
        yaml = { "oxfmt" },
        css = { "oxfmt" },
        json = { "oxfmt" },
        jsonc = { "oxfmt" },
      },
    })
  end,
})
