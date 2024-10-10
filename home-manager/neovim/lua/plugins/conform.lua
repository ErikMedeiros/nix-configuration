return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format({ async = true })
      end,
      mode = { "n", "v" },
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_after_save = {
      lsp_format = "fallback",
    },

    formatters = {
      flakefmt = {
        command = "nix",
        args = { "fmt", "--", "-q", "-" },
      },
    },

    formatters_by_ft = {
      css = { "prettierd", "prettier", stop_after_first = true },
      html = { "prettierd", "prettier", stop_after_first = true },
      javascript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      markdown = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      yaml = { "prettierd", "prettier", stop_after_first = true },

      nix = { "flakefmt" },
      go = { "gofmt" },
      lua = { "stylua" },
      rust = { "rustfmt" },
      zig = { "zigfmt" },

      ["*"] = { "codespell" },
      ["_"] = { "trim_whitespace" },
    },
  },
}
