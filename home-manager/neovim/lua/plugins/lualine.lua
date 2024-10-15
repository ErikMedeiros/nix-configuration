return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local min_theme = require("lualine.themes.min-theme")
    min_theme.normal.c = min_theme.normal.b
    min_theme.normal.x = min_theme.normal.b
    min_theme.normal.y = min_theme.normal.b

    require("lualine").setup({
      options = { theme = min_theme },
      sections = { lualine_c = { { "filename", path = 4 } } },
    })
  end,
}
