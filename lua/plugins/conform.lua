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
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    markdown = { "prettierd" },
    html = { "prettierd" },
    yaml = { "prettierd" },
    css = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
  },
})
