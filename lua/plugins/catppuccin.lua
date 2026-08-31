vim.pack.add({ { src = "https://github.com/catppuccin/nvim", name = "catppuccin" } })

local utils = require("catppuccin.utils.colors")
require("catppuccin").setup({
  flavour = "mocha",
  transparent_background = true,
  custom_highlights = function(colors)
    return {
      CursorLine = { bg = utils.darken(colors.surface1, 0.75, colors.base) },
      BlinkCmpDoc = { bg = utils.darken(colors.surface0, 0.5, colors.base) },
      BlinkCmpMenu = { bg = colors.surface0 },
      BlinkCmpSignatureHelp = { bg = colors.mantle },
      BlinkCmpSignatureHelpActiveParameter = { bg = colors.surface1, bold = true, italic = true },
      -- custom mini tabline
      MiniTablineCurrent = { fg = colors.mantle, bg = colors.peach, style = { "bold", "italic" } },
      MiniTablineFill = { bg = colors.base },
      MiniTablineHidden = { fg = colors.surface2, bg = colors.base },
      MiniTablineModifiedCurrent = { fg = colors.base, bg = colors.maroon, style = { "bold", "italic" } },
      MiniTablineModifiedHidden = { fg = colors.maroon, bg = colors.none },
      MiniTablineModifiedVisible = { fg = colors.maroon, bg = colors.none },
      MiniTablineTabpagesection = { fg = colors.surface1, bg = colors.base },
      MiniTablineVisible = { fg = colors.subtext1, bg = colors.base },
    }
  end,
  integrations = {
    blink_cmp = true,
    flash = true,
    diffview = true,
    mini = {
      enabled = true,
      indentscope_color = "peach",
    },
    snacks = {
      enabled = true,
      indent_scope_color = "peach",
    },
  },
})

vim.cmd("colorscheme catppuccin-nvim")
