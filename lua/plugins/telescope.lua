return {
    dir = CFGP..'/deps/plugins/telescope.nvim',
    dependencies = {
        { dir = CFGP..'/deps/plugins/plenary.nvim' },
        { dir = CFGP..'/deps/plugins/nvim-web-devicons' }
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')
        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    ".*/deps/.*",
                },
                mappings = {
                    i = { ['<Esc>'] = actions.close },
                    n = { ['<Esc>'] = actions.close },
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
