-- ====================
-- Mini Icons
-- ====================
vim.pack.add({ "https://github.com/nvim-mini/mini.icons" })

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- ====================
-- Mini Files
-- ====================
vim.keymap.set("n", "<leader>e", function()
  vim.pack.add({ "https://github.com/nvim-mini/mini.files" })
  require("mini.files").setup({
    content = {
      filter = function(fs_entry)
        return not vim.startswith(fs_entry.name, ".")
      end,
    },
    mappings = {
      go_in_plus = "l",
      go_in = "L",
    },
  })

  -- Toggle File explore
  if MiniFiles.close() == nil then
    MiniFiles.open(vim.api.nvim_buf_get_name(0))
  end
end, { desc = "Open File Explore" })

-- Toggle hidden files
local show_dotfiles = false

local filter_show = function()
  return true
end

local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  local new_filter = show_dotfiles and filter_show or filter_hide
  MiniFiles.refresh({ content = { filter = new_filter } })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle hidden Files" })
  end,
})

-- Open file in split window
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    local cur_target = MiniFiles.get_explorer_state().target_window
    local new_target = vim.api.nvim_win_call(cur_target, function()
      vim.cmd(direction .. " split")
      return vim.api.nvim_get_current_win()
    end)

    MiniFiles.set_target_window(new_target)
    MiniFiles.go_in({ close_on_file = true })
  end

  local desc = "Split " .. direction
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    local buf_id = args.data.buf_id
    map_split(buf_id, "<C-s>", "belowright horizontal")
    map_split(buf_id, "<C-v>", "belowright vertical")
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})

-- ====================
-- Mini Tabline
-- ====================
vim.api.nvim_create_autocmd("BufEnter", {
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/nvim-mini/mini.tabline" })
    require("mini.tabline").setup({
      tabpage_section = "right",
    })
  end,
})

-- ====================
-- Mini Pairs
-- ====================
vim.api.nvim_create_autocmd("InsertEnter", {
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/nvim-mini/mini.pairs" })
    require("mini.pairs").setup()
  end,
})

-- ====================
-- Mini clue
-- ====================
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/nvim-mini/mini.clue" })
    local miniclue = require("mini.clue")
    miniclue.setup({
      triggers = {
        -- Leader triggers
        { mode = { "n", "x" }, keys = "<Leader>" },

        -- `[` and `]` keys
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },

        -- `g` key
        { mode = { "n", "x" }, keys = "g" },

        -- Registers
        { mode = { "n", "x" }, keys = '"' },
        { mode = { "i", "c" }, keys = "<C-r>" },

        -- `z` key
        { mode = { "n", "x" }, keys = "z" },
      },

      clues = {
        miniclue.gen_clues.square_brackets(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.z(),
        { mode = "n", keys = "<leader>f", desc = "Find" },
        { mode = "n", keys = "<leader>w", desc = "Window" },
        { mode = "n", keys = "<leader>b", desc = "Buffers" },
        { mode = "n", keys = "<leader>g", desc = "Git" },
        { mode = "n", keys = "<leader>h", desc = "Git Hunk" },
        { mode = "n", keys = "<leader>t", desc = "Toggle" },
        { mode = "n", keys = "<leader>u", desc = "UI" },
        { mode = "n", keys = "<leader>s", desc = "Search" },
        { mode = "n", keys = "<leader>c", desc = "Code" },
      },
    })
  end,
})

-- ====================
-- Mini hipatterns
-- ====================
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/nvim-mini/mini.hipatterns" })
    local hipatterns = require("mini.hipatterns")
    hipatterns.setup({
      highlighters = {
        fixme = { pattern = "FIXME", group = "MiniHipatternsFixme" },
        hack = { pattern = "HACK", group = "MiniHipatternsHack" },
        todo = { pattern = "TODO", group = "MiniHipatternsTodo" },
        note = { pattern = "NOTE", group = "MiniHipatternsNote" },
        bug = { pattern = "BUG", group = "MiniHipatternsFixme" },
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
  end,
})
