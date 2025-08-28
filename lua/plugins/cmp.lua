-- Варианты автодополнения вводимого текста 

return {
    dir = CFGP..'/deps/plugins/nvim-cmp',
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        { dir = CFGP..'/deps/plugins/cmp-buffer' },
        { dir = CFGP..'/deps/plugins/cmp-path' },
        { dir = CFGP..'/deps/plugins/cmp-cmdline' },
        { dir = CFGP..'/deps/plugins/cmp-nvim-lsp' },
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
