-- Настройки цветовой темы vim-colors-plain
return {
    dir = CFGP.."/deps/plugins/vim-colors-plain",
        config = function()
        -- Выбор варианта темы: light или dark
        vim.opt.background = "dark"  -- или "light" для светлой темы
        -- Применяем тему
        vim.cmd("colorscheme plain")
        -- Дополнительные настройки
        vim.cmd([[
            highlight! LineNr guibg=NONE ctermbg=NONE
            highlight! SignColumn guibg=NONE ctermbg=NONE
        ]])
    end
}
