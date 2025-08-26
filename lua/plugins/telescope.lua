return {
    dir = CFGP..'/deps/plugins/telescope.nvim',
    dependencies = {
        { dir = CFGP..'/deps/plugins/plenary.nvim' }
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        telescope.setup({
            defaults = {
                preview = false,
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
