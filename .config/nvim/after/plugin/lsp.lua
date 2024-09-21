local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.setup()

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'rust_analyzer',
    'clangd',
    'elixirls',
    'gopls',
    'pylsp'
  },
  handlers = {
    lsp.default_setup,
  }
})
