vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    vim.pack.add({
      "https://github.com/rafamadriz/friendly-snippets",
      { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
    })

    require("blink.cmp").setup({
      keymap = {
        preset = "enter",
        ["<C-space>"] = {},
        ["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
      },
      signature = { enabled = true },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      enabled = function()
        if vim.bo.buftype == "nofile" then
          return false
        end
        return true
      end,
    })
  end,
})
