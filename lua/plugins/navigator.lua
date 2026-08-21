vim.schedule(function()
  vim.pack.add({ "https://github.com/numToStr/Navigator.nvim" })
  require("Navigator").setup({
    mux = "auto",
  })
  -- Move to window useing the <ctrl>hjkl keys
  vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>", { desc = "Go to Left Window" })
  vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>", { desc = "Go to Lower Window" })
  vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>", { desc = "Go to Upper Window" })
  vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>", { desc = "Go to Right Window" })
end)
