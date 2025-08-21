-- Настройки дерева директорий

-- Плагин загружается только в момент нажатия какой то его сочетания клавиш
-- либо при запуске nvim с директорией в аргумент

return {
    dir = "~/.config/nvim/deps/plugins/nvim-tree.lua",
    dependencies = {
        { dir = "~/.config/nvim/deps/plugins/nvim-web-devicons" }
    },
    -- Загружаем при старте, если открыта директория, или по клавишам
    event = function()
        if vim.fn.argc() == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                return "VimEnter"
            end
        end
    end,
    keys = {
        {
            "<A-e>", function()
                require("nvim-tree.api").tree.toggle()
                if require("nvim-tree.api").tree.is_visible() then
                    vim.cmd("wincmd p")
                end
            end,
            mode = "n", noremap = true, silent = true, desc = "Toggle NvimTree and focus back"
        },
        {
            "<A-]>", function()
                require("nvim-tree.api").tree.change_root_to_node()
            end, mode = "n", noremap = true, silent = true
        },
        {
            "<A-t>", function()
                require("nvim-tree.api").node.open.tab()
            end, mode = "n", noremap = true, silent = true
        },
    },
    config = function()
        require("nvim-tree").setup {
            sync_root_with_cwd = true,
            filters = {
                git_ignored = false,
                custom = {
                    -- не показывать директорию .git
                    ".git$"
                }
            },
            -- live filter - тот который открывается на f, закрывается на F
            live_filter = {
                always_show_folders = false,
            },
            view = {
                cursorline = false,
                signcolumn = "yes",
            }
        }
        local nvt_api = require("nvim-tree.api")
        -- Автоматически открывать nvim-tree при загрузке, если открыта директория
        if vim.fn.argc() == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                nvt_api.tree.open()
            end
        end
        -- При закрытии файла дерево директорий также закрывается
        -- если этот файл был один на вкладке 
        vim.api.nvim_create_autocmd("QuitPre", {
            callback = function()
                local tabpage = vim.api.nvim_get_current_tabpage()
                local windows = vim.api.nvim_tabpage_list_wins(tabpage)
                if nvt_api.tree.winid() ~= nil and #windows == 2 then
                    nvt_api.tree.close()
                end
            end,
        })
    end
}
