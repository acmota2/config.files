-- remaps
vim.keymap.set("n", "<leader>e", "<cmd>Neotree<CR>")

-- actual setup
local builtin = require('neo-tree')
builtin.setup({
    close_if_last_window = false,
    popup_border_style = "rounded",
    enable_diagnostics = true,
    sort_case_insensitive = false,
    window = {
        position = "left",
        width = 40,
        mapping_options = {
            noremap = true,
            nowait = true,
        },
    },
    filesystem = {
        filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = false,
            hide_gitignored = false,
        },
    },      
})
