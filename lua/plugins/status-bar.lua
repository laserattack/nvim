-- Настройки статус-бара

return  {
    dir = '~/.config/nvim/deps/plugins/lualine.nvim',
    dependencies = {
        { dir = '~/.config/nvim/deps/plugins/nvim-web-devicons' }
    },
    config = function()
        require('lualine').setup {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = { left = '', right = ''},
                section_separators = { left = '', right = ''},
                -- Отключение плагина для указанных типов файлов
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                -- Одна статусная строка для всех окон
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16, -- ~60fps
                    events = {
                        'WinEnter',
                        'BufEnter',
                        'BufWritePost',
                        'SessionLoadPost',
                        'FileChangedShellPost',
                        'VimResized',
                        'Filetype',
                        'CursorMoved',
                        'CursorMovedI',
                        'ModeChanged',
                    },
                }
            },
            sections = {
                lualine_a = {
                    'mode',
                    {
                        "lsp_status",
                        icon = ' LS:',
                        symbols = {
                            spinner = { '...' },
                            done = '✓',
                            separator = ' ',
                        },
                        ignore_lsp = {},
                    }
                },
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
            },
        }
    end
}
