return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        -- auto_install = true,
        -- ensure_installed = "all",
        highlight = { enable = true },
        indent = { enable = true },
        autopairs = { enable = true },
        autotags = { enable = true },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
