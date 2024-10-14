return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "j-hui/fidget.nvim", opts = {} },
    "hrsh7th/cmp-nvim-lsp",
    "decodetalkers/csharpls-extended-lsp.nvim",
  },
  config = function()
    local servers = {
      csharp_ls = {},
      lua_ls = {},
      nixd = {},
      tailwindcss = {},
      ts_ls = {},
      zls = {},
    }

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities =
      vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    for server_name, config in pairs(servers) do
      config.capabilities =
        vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
      require("lspconfig")[server_name].setup(config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
        end

        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("<C-s>", vim.lsp.buf.signature_help, "[S]ignature Help")

        local builtin = require("telescope.builtin")

        map("gr", builtin.lsp_references, "[G]oto [R]eferences")
        map("gI", builtin.lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>ds", builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
        map("<leader>ws", builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

        if vim.bo[event.buf].filetype == "cs" then
          map("gd", "<cmd>Telescope csharpls_definition<CR>", "[G]oto [D]efinition")
          map("gt", "<cmd>Telescope csharpls_definition<CR>", "[G]oto [T]ype Definition")
        else
          map("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
          map("gt", builtin.lsp_type_definitions, "[G]oto [T]ype Definition")
        end
      end,
    })
  end,
}
