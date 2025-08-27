return {
    dir = CFGP..'/deps/plugins/telescope.nvim',
    dependencies = {
        { dir = CFGP..'/deps/plugins/plenary.nvim' },
        { dir = CFGP..'/deps/plugins/nvim-web-devicons' }
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        telescope.setup({
            defaults = {
                preview = false,
                file_ignore_patterns = {
                    ".*/deps/.*",
                },
                mappings = {
                    i = {
                        ['<Esc>'] = require('telescope.actions').close,
                        ['<A-f>'] = require('telescope.actions').close,
                    },
                    n = {
                        ['<A-f>'] = require('telescope.actions').close,
                        ['<Esc>'] = require('telescope.actions').close,
                    },
                },
            },
            pickers = {
                find_files = {
                    previewer = false,
                },
            },
        })
        vim.keymap.set('n', '<A-f>', builtin.find_files, {})
    end
}
