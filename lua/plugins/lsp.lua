-- Настройки LSP серверов

-- Чтобы добавить сервер надо в табличку добавить новое поле с его настройками
-- в cmd добавить путь до бинарника сервера

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
                    -- кучу .lua файлов.
                    -- А для простого программирования на .lua 50 файлов хватает
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

-- Общие настройки
local general_settings = function(_, _)
    vim.diagnostic.config({
        virtual_text = {
            -- позиция текста об ошибках - в правом конце строки
            virt_text_pos = 'right_align',
        },
        -- не показывать значки на полях
        signs = false,
        -- не подчеркивать места с ошибками
        underline = false,
    })
end

-- Функция для проверки наличия серверов
local function check_lsp_path(_, binary_path)
    if vim.fn.executable(binary_path) ~= 1 then
        return false
    end
    return true
end

return {
    dir = '~/.config/nvim/deps/plugins/nvim-lspconfig',
    dependencies = {
        { dir = '~/.config/nvim/deps/plugins/lsp-status.nvim' }
    },
    config = function()
        for server_name, server_settings in pairs(ls_settings) do
            if not check_lsp_path(server_name, server_settings.cmd[1]) then
               goto continue
            end

            server_settings.on_attach = general_settings
            require("lspconfig")[server_name].setup(server_settings)

            ::continue::
        end
    end
}
