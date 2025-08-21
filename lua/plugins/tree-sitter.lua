-- Настройка treesitter`a

return {
    dir = "~/.config/nvim/deps/plugins/nvim-treesitter",
    event = {
        "BufReadPre *.lua", "BufNewFile *.lua",
        "BufReadPre *.zig", "BufNewFile *.zig",
        "BufReadPre *.c", "BufNewFile *.c",
        "BufReadPre *.cpp", "BufNewFile *.cpp",
        "BufReadPre *.py", "BufNewFile *.py",
    },
    config = function()

        local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

        -- Выставляю локальные пути до репозиториев с парсерами
        -- если их не выставить, то парсеры будут скачиваться с гитхаба
        -- аналогично можно указать путь до локального репозитория с парсером для 
        -- любого языка из ensure_installed
        parser_config.c.install_info.url = "~/.config/nvim/deps/tree-sitter-parsers/tree-sitter-c"
        parser_config.cpp.install_info.url = "~/.config/nvim/deps/tree-sitter-parsers/tree-sitter-cpp"
        parser_config.lua.install_info.url = "~/.config/nvim/deps/tree-sitter-parsers/tree-sitter-lua"
        parser_config.zig.install_info.url = "~/.config/nvim/deps/tree-sitter-parsers/tree-sitter-zig"
        parser_config.python.install_info.url = "~/.config/nvim/deps/tree-sitter-parsers/tree-sitter-python"

        -- Тут надо указать нужные языки
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "lua", "zig", "python" },
            sync_install = true,
            auto_install = false,
            highlight = {
                enable = true,
                -- Сюда можно написать список парсеров которые отключить 
                disable = {},
            },
        })
    end
}
