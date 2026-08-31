vim.api.nvim_create_autocmd("BufReadPre", {
  once = true,
  callback = function()
    vim.pack.add({
      "https://github.com/nvim-lua/plenary.nvim",
      "https://github.com/folke/todo-comments.nvim",
    })
    require("todo-comments").setup({})
    vim.keymap.set("n", "<leader>ft", function()
      Snacks.picker.todo_comments()
    end, { desc = "Find Todo" })
  end,
})
