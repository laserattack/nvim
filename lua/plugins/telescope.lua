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
                mappings = {
                    i = { ['<Esc>'] = actions.close },
                    n = { ['<Esc>'] = actions.close },
                },
            },
            pickers = {
                find_files = {
                    previewer = false,
                    -- Ищу через rg, игнорю директорию с зависимостями
                    find_command = {
                        "rg", "--files", "--hidden",
                        -- "--glob", "!**/deps/**",
                        "--glob", "!**/.git/**"
                    },
                },
                live_grep = {
                    -- Аргументы по умолчанию + игнор директории с зависимостями
                    vimgrep_arguments = {
                        "rg",
                        "--hidden",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        -- "--glob", "!**/deps/**",
                        "--glob", "!**/.git/**"
                    }
                }
            },
        })
        vim.keymap.set('n', 'ff', builtin.find_files, {})
        vim.keymap.set('n', 'fg', builtin.live_grep, {})
    end
}
