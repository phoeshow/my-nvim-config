vim.loader.enable()
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.pack.add({ "https://github.com/dstein64/vim-startuptime" })

require("options")

require("keymaps")

require("autocmds")

require("plugins")

