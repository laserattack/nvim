-- Настройки дерева директорий

return {
    dir = "~/.config/nvim/deps/plugins/nvim-tree.lua",
    dependencies = {
        { dir = "~/.config/nvim/deps/plugins/nvim-web-devicons" }
    },
    config = function()
        require("nvim-tree").setup({
            filters = {
                git_ignored = false,
            },
            -- live filter - тот который открывается на f,
            -- закрывается на F
            live_filter = {
                always_show_folders = false,
            },
            renderer = {
                root_folder_label = false,
            },
            view = {
                cursorline = false,
                signcolumn = "yes",
            }
        })
        local nvt_api = require("nvim-tree.api")
        -- При закрытии файла дерево директорий также закрывается
        vim.api.nvim_create_autocmd("QuitPre", {
            callback = function()
                if nvt_api.tree.winid() ~= nil then
                    nvt_api.tree.close()
                end
            end,
        })
        -- alt+e - открыть/закрыть меню директорий
        vim.keymap.set("n", "<A-e>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
        -- alt+] - сделать выбранную директорию корневой
        vim.keymap.set("n", "<A-]>", nvt_api.tree.change_root_to_node, { noremap = true, silent = true })
        -- alt+t - открывает файл в новой вкладке
        vim.keymap.set("n", "<A-t>", nvt_api.node.open.tab, { noremap = true, silent = true })
    end
}
