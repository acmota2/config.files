return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      c = { "clang-format" },
      cpp = { "clang-format" },
      css = { "prettierd" },
      graphql = { "prettierd" },
      html = { "prettierd" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      json = { "prettierd" },
      lua = { "stylua" },
      python = { "isort", "black" },
      svelte = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      yaml = { "prettierd" },
    },
  },
}
