vim.schedule(function()
  vim.pack.add({ "https://github.com/sindrets/diffview.nvim" })

  require("diffview").setup({
    view = {
      merge_tool = {
        layout = "diff3_mixed",
      },
    },
  })

  vim.keymap.set("n", "<leader>gd", "<CMD>DiffviewOpen<CR>", { desc = "Open Diffview" })
  vim.keymap.set("n", "<leader>gh", "<CMD>DiffviewFileHistory %<CR>", { desc = "View current file hisory" })
end)
