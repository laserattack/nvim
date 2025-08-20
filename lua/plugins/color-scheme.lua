-- Настройки цветовой темы

return  {
    dir = "~/.config/nvim/deps/plugins/kanagawa.nvim",
    config = function()
        vim.cmd("colorscheme kanagawa-wave")
        -- Фон у колонки с номерами строк выключаю
        vim.cmd([[
            highlight! LineNr guibg=NONE ctermbg=NONE
            highlight! SignColumn guibg=NONE ctermbg=NONE
        ]])
    end
}
