vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw for nvim-tree plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.pack.add({ "https://github.com/dstein64/vim-startuptime" })

require("options")

require("keymaps")

require("autocmds")

require("plugins")
