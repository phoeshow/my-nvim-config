-- ====================
-- Mini Icons
-- ====================
vim.pack.add({ "https://github.com/nvim-mini/mini.icons" })

require("mini.icons").setup()
MiniIcons.mock_nvim_web_devicons()

-- ====================
-- Mini Tabline
-- ====================
vim.api.nvim_create_autocmd("BufReadPost", {
  once = true,
  callback = function()
    vim.pack.add({ "https://github.com/nvim-mini/mini.tabline" })
    require("mini.tabline").setup({
      format = function(buf_id, label)
        local prefix = vim.api.nvim_get_current_buf() == buf_id and "▎" or "▏"
        local suffix = vim.bo[buf_id].modified and "+ " or ""
        return prefix .. MiniTabline.default_format(buf_id, label) .. suffix
      end,
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
vim.api.nvim_create_autocmd("UIEnter", {
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
        { mode = "n", keys = "<leader>f", desc = " Find" },
        { mode = "n", keys = "<leader>w", desc = " Window" },
        { mode = "n", keys = "<leader>b", desc = " Buffers" },
        { mode = "n", keys = "<leader>g", desc = " Git" },
        { mode = "n", keys = "<leader>h", desc = " Git Hunk" },
        { mode = "n", keys = "<leader>t", desc = " Toggle" },
        { mode = "n", keys = "<leader>u", desc = " UI" },
        { mode = "n", keys = "<leader>s", desc = "󰈞 Search" },
        { mode = "n", keys = "<leader>c", desc = " Code" },
      },
      window = {
        delay = 250,
      },
    })
  end,
})
