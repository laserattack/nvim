-- Настройки LSP серверов

-- Индикатор включенной диагностики
local diagnostics_active = false

-- Чтобы добавить сервер надо в табличку добавить новое поле с его настройками
-- в cmd добавить путь до бинарника сервера
-- еще снизу в поле event добавить аналогичную строку для нового расширения
local ls_settings = {
    lua_ls = {
        cmd = { vim.fn.expand('~/.config/nvim/deps/lsp/lua/bin/lua-language-server') },
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- чтобы не было Undefined global variable vim
                    globals = { 'vim' }
                },
                workspace = {
                    -- Ограничение на кол-во загружаемых для анализа файлов
                    -- а то редактирование конфига может жрать 2гб, т.к. грузит
                    -- кучу .lua файлов. А для простого программирования на .lua 50 файлов хватает
                    maxPreload = 50,
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    zls = {
        cmd = { vim.fn.expand('~/.config/nvim/deps/lsp/zls/zls') },
    },
    clangd = {
        cmd = { vim.fn.expand('~/.config/nvim/deps/lsp/clangd/bin/clangd') },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        single_file_support = true,
        capabilities = {
            offsetEncoding = { "utf-16" },
        },
    },
}

-- Функция для проверки наличия серверов
local function check_lsp_path(_, binary_path)
    if vim.fn.executable(binary_path) ~= 1 then
        return false
    end
    return true
end

local function toggle_diagnostics()
    diagnostics_active = not diagnostics_active

    if diagnostics_active then
        vim.diagnostic.config({
            virtual_text = {
                virt_text_pos = 'right_align',
                suffix = " ",
            },
            signs = false,
            underline = false,
        })
    else
        vim.diagnostic.config({
            virtual_text = false,
            signs = false,
            underline = false,
        })
    end
end

return {
    dir = '~/.config/nvim/deps/plugins/nvim-lspconfig',
    -- Плагиз загружается когда либо открывается какой то существующий файл
    -- или создается какой то новый файл (из перечисленных расширений)
    event = {
        "BufReadPre *.lua", "BufNewFile *.lua",
        "BufReadPre *.zig", "BufNewFile *.zig",
        "BufReadPre *.c", "BufNewFile *.c",
        "BufReadPre *.cpp", "BufNewFile *.cpp",
    },
    --
    dependencies = {
        { dir = '~/.config/nvim/deps/plugins/lsp-status.nvim' }
    },
    config = function()
        toggle_diagnostics()
        -- Выключение/включение предупреждений на полях
        vim.keymap.set('n', '<A-d>', toggle_diagnostics, {
            noremap = true,
            silent = true,
        })

        for server_name, server_settings in pairs(ls_settings) do
            if not check_lsp_path(server_name, server_settings.cmd[1]) then
               goto continue
            end

            require("lspconfig")[server_name].setup(server_settings)

            ::continue::
        end
    end
}
