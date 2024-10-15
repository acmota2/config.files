return {
  {
    {
      "L3MON4D3/LuaSnip",
    },
    {
      "VonHeikemen/lsp-zero.nvim",
      branch = "v4.x",
      lazy = true,
      config = false,
    },
    {
      "williamboman/mason.nvim",
      lazy = false,
      opts = {},
    },

    -- Autocompletion
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
          sources = {
            { name = "nvim_lsp" },
          },
          mapping = {
            ["<CR>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                if luasnip.expandable() then
                  luasnip.expand()
                else
                  cmp.confirm({
                    select = true,
                  })
                end
              else
                fallback()
              end
            end),

            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.locally_jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, { "i", "s" }),

            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { "i", "s" }),
          },
          --  cmp.mapping.preset.insert({
          --  ["<CR>"] = cmp.mapping.complete(),
          --  ["<Shift-Tab>"] = cmp.mapping.scroll_docs(-4),
          --  ["<Tab>"] = cmp.mapping.scroll_docs(4),
          --}),
          snippet = {
            expand = function(args)
              vim.snippet.expand(args.body)
            end,
          },
        })
      end,
    },

    -- LSP
    {
      "neovim/nvim-lspconfig",
      cmd = { "LspInfo", "LspInstall", "LspStart" },
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
      },
      init = function()
        -- Reserve a space in the gutter
        -- This will avoid an annoying layout shift in the screen
        vim.opt.signcolumn = "yes"
      end,
      config = function()
        local lsp_defaults = require("lspconfig").util.default_config

        -- Add cmp_nvim_lsp capabilities settings to lspconfig
        -- This should be executed before you configure any language server
        lsp_defaults.capabilities =
          vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

        -- LspAttach is where you enable features that only work
        -- if there is a language server active in the file
        vim.api.nvim_create_autocmd("LspAttach", {
          desc = "LSP actions",
          callback = function(event)
            local opts = { buffer = event.buf }

            vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
            vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
            vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
            vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
            vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
            vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
            vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
            vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
            vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
            vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
          end,
        })

        require("mason-lspconfig").setup({
          ensure_installed = { "lua_ls", "rust_analyzer" },
          handlers = {
            -- this first function is the "default handler"
            -- it applies to every language server without a "custom handler"
            function(server_name)
              require("lspconfig")[server_name].setup({})
            end,
          },
        })
      end,
    },
  },
}
