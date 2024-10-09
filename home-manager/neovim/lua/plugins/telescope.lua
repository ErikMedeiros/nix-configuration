return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        extensions = {
            ['ui-select'] = { require("telescope.themes").get_dropdown() }
        },
        pickers = {
            colorscheme = { enable_preview = true }
        },
    },
    config = function(opts)
        require("telescope").setup(opts)

        local builtin = require("telescope.builtin")

        vim.keymap.set("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previwer = false,
            })
        )
        end, { desc = "[/] Fuzzily search in current buffer" })

        vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
        vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
        vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
        vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
        vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })

        vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "LSP: [G]oto [R]eferences" })
        vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "LSP: [D]ocument [S]ymbols" })
        vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, { desc = "LSP: [W]orkspace [S]ymbols" })
    end,}
