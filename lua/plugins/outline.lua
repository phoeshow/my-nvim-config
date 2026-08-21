local setup_already = false
local setup = function()
  if not setup_already then
    require("outline").setup()
    setup_already = true
  end
end
vim.keymap.set("n", "<leader>to", function()
  vim.pack.add({ "https://github.com/hedyhli/outline.nvim" })
  setup()

  vim.cmd("Outline")
end, { desc = "Toggle Outline" })
