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
                file_ignore_patterns = {
                    ".*/deps/.*",
                },
                mappings = {
                    i = { ['<Esc>'] = require('telescope.actions').close },
                    n = { ['<Esc>'] = require('telescope.actions').close },
                },
            },
            pickers = {
                find_files = {
                    previewer = false,
                },
            },
        })
        vim.keymap.set('n', 'ff', builtin.find_files, {})
    end
}
