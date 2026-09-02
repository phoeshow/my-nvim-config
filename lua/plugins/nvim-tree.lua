vim.pack.add({
  "https://github.com/nvim-tree/nvim-tree.lua",
})

local nvimtree = require("nvim-tree")

local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")
  local function opts(desc)
    return { desc = desc, buf = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.map.on_attach.default(bufnr)

  -- replace show help map
  vim.keymap.del("n", "g?", { buf = bufnr })
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  -- replace show hidden files
  vim.keymap.set("n", ".", api.filter.dotfiles.toggle, opts("Toggle hidden files"))
  -- replace split open
  vim.keymap.del("n", "<C-x>", { buf = bufnr })
  vim.keymap.del("n", "<C-v>", { buf = bufnr })
  vim.keymap.set("n", "s", api.node.open.vertical, opts("Open: Vertical Split"))
  -- remove open in new tab
  vim.keymap.del("n", "<C-t>", { buf = bufnr })
  -- remap copy file
  vim.keymap.set("n", "y", api.fs.copy.node, opts("Copy"))
  -- remap create file
  vim.keymap.del("n", "a", { buf = bufnr })
  vim.keymap.set("n", "c", api.fs.create, opts("Create File Or Directory"))
end

nvimtree.setup({
  actions = {
    open_file = {
      quit_on_open = true,
      window_picker = {
        exclude = {
          filetype = { "Outline" },
        },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    highlight_hidden = "name",
    highlight_modified = "name",
    icons = {
      
      glyphs = {
        git = {
          untracked = "󰯫",
          unstaged = "󰰏",
          staged = "",
          ignored = ""
        },
      },
    },
  },
  on_attach = my_on_attach,
  filters = {
    dotfiles = true,
    git_ignored = false,
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = " Open File Explorer" })
