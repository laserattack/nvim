-- Варианты автодополнения вводимого текста 

return {
    dir = '~/.config/nvim/deps/plugins/nvim-cmp',
    dependencies = {
        { dir = '~/.config/nvim/deps/plugins/cmp-buffer' },
        { dir = '~/.config/nvim/deps/plugins/cmp-path' },
        { dir = '~/.config/nvim/deps/plugins/cmp-cmdline' },
        { dir = '~/.config/nvim/deps/plugins/cmp-nvim-lsp' },
    },
    config = function()
        local cmp = require('cmp')
        cmp.setup({
            -- Настройка красивого стиля окна с вариантами дополнения
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },
            -- Маппинги
            mapping = cmp.mapping.preset.insert({
                -- enter чтобы выбрать нужный вариант
                -- переключение вариантов на стрелочки или на tab/shift+tab
                ['<CR>'] = cmp.mapping.confirm({select = true}),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, {"i", "s"}),
                ["<S-Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, {"i", "s"})
            }),
            -- Источник автодополнения - текущий буффер, lsp сервер
            sources = cmp.config.sources({{name = "nvim_lsp"}}, {{name = 'buffer'}})
        })
        -- Автодополнение для поиска (/ и ?)
        cmp.setup.cmdline({'/', '?'}, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {{name = 'buffer'}}
        })
        -- Автодополнение для команд (:)
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({{name = 'path'}}, {{name = 'cmdline'}})
        })
    end
}
