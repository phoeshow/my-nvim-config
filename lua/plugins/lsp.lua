vim.api.nvim_create_autocmd("FileType", {
  once = true,
  pattern = "lua",
  callback = function()
    vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
    require("lazydev").setup({
      library = {
        -- It can also be a table with trigger words / mods
        -- Only load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      -- disable when a .luarc.json file is found
      enabled = function(root_dir)
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    })
  end,
})

vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup({
  automatic_enable = false,
})

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        format = { enable = false },
      },
    },
  },

  vtsls = {},

  rust_analyzer = {},

  tailwindcss = {},

  cssls = {},

  html = {},
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  "stylua", -- Lua formatter
  "oxfmt", -- JS/TS/Json/makdown/html/css formatter
  "oxlint", -- JS/TS linter
})

require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    local picker = Snacks.picker

    map("gd", picker.lsp_definitions, "Goto Definitions")
    map("grr", picker.lsp_references, "Goto References")
    map("gD", picker.lsp_declarations, "Goto Declaration")
    map("gI", picker.lsp_implementations, "Goto Implementations")
    map("gt", picker.lsp_type_definitions, "Goto Type Definitions")

    map("<leader>ca", vim.lsp.buf.code_action, "Coda Action")
    map("<leader>cr", vim.lsp.buf.rename, "Code Rename")

    map("<leader>fd", picker.diagnostics_buffer, "Find Diagnostics(Buffer)")
    map("<leader>fD", picker.diagnostics, "Find Diagnostics(Workspace)")

    map("K", function()
      vim.lsp.buf.hover({ border = "single" })
    end, "LSP: Hover")

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup("my-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("my-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "my-lsp-highlight", buffer = event2.buf })
        end,
      })
    end
  end,
})
