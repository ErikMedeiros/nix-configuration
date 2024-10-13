return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    require("lint").linters_by_ft = {
      javascript = { vim.fn.executable("eslint_d") == 1 and "eslint_d" or "eslint" },
      typescript = { vim.fn.executable("eslint_d") == 1 and "eslint_d" or "eslint" },
      javascriptreact = { vim.fn.executable("eslint_d") == 1 and "eslint_d" or "eslint" },
      typescriptreact = { vim.fn.executable("eslint_d") == 1 and "eslint_d" or "eslint" },
      nix = { "nix" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("lint", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
