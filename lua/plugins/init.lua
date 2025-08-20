-- Настройка менеджера плагинов

local lazypath = vim.fn.stdpath("config") .. "/deps/plugins/lazy.nvim"
vim.opt.rtp:prepend(lazypath)
-- Подключаемые плагины
local plugins = {
    -- Дерево директорий
    require("plugins/nvim-tree"),
    -- Цветовая тема
    require("plugins/color-scheme"),
    -- Treesitter - умная подсветка для выбранных языков (с учетом AST)
    require("plugins/tree-sitter"),
    -- Auto complete - предлагает варианты дополнения
    require("plugins/cmp"),
    -- lsp
    require("plugins/lsp"),
    -- status bar
    require("plugins/status-bar"),
    -- Для установки парных символов вокруг выделенного текста
    require("plugins/mini-surround"),
    -- Окно при входе в nvim
    require("plugins/dashboard"),
}

require("lazy").setup(plugins)
